#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Fusion JSON de la configuration OpenCode avec le provider Mammouth AI.

Ce script est appele par update-opencode-mammouth.sh, qui se charge du
telechargement du catalogue (curl) et de l'appel de l'API Ollama. Le
script Python :

  * lit le catalogue Mammouth (JSON local) ;
  * convertit les couts USD/token en USD / million de tokens ;
  * fusionne le provider "mammouth" dans la configuration OpenCode sans
    ecraser les autres providers ni les reglages manuels ;
  * ajoute (optionnellement) les modeles Ollama sans toucher aux modeles
    declares manuellement ;
  * ecrit le fichier de configuration de maniere atomique et idempotente.

Aucune cle API n'est ecrite sur disque : le provider mammouth declare
uniquement le nom de la variable d'environnement MAMMOUTH_API_KEY.
"""

import argparse
import json
import os
import sys
import tempfile

TOKENS_PER_MILLION = 1_000_000
OPENAI_COMPATIBLE_NPM = "@ai-sdk/openai-compatible"
MAMMOUTH_BASE_URL = "https://api.mammouth.ai/v1"
MAMMOUTH_ENV_VAR = "MAMMOUTH_API_KEY"
CONFIG_SCHEMA = "https://opencode.ai/config.json"


def fail(message, code=1):
    sys.stderr.write("Erreur: %s\n" % message)
    sys.exit(code)


def read_json(path, label):
    try:
        with open(path, "r", encoding="utf-8") as handle:
            return json.load(handle)
    except FileNotFoundError:
        fail("%s introuvable: %s" % (label, path), 2)
    except json.JSONDecodeError as exc:
        fail("%s invalide (%s): %s" % (label, path, exc), 2)
    except OSError as exc:
        fail("lecture impossible de %s (%s): %s" % (label, path, exc), 2)


def normalize_base(url):
    url = (url or "").strip().rstrip("/")
    if not url:
        return "http://127.0.0.1:11434"
    if "://" not in url:
        url = "http://" + url
    return url


def mammoth_models(source):
    """Construit les entrees de modeles OpenCode depuis le catalogue Mammouth.

    Source : objet {"data": [ {id, object, created, owned_by, model_info{...}} ]}
    ou directement une liste de modeles.
    """
    if isinstance(source, dict):
        entries = source.get("data")
        if entries is None:
            entries = source.get("models")
    elif isinstance(source, list):
        entries = source
    else:
        entries = None
    if not isinstance(entries, list):
        fail("structure inattendue du catalogue Mammouth (liste 'data' attendue)", 2)

    models = {}
    for entry in entries:
        if not isinstance(entry, dict):
            continue
        model_id = entry.get("id")
        if not isinstance(model_id, str) or not model_id:
            continue
        info = entry.get("model_info")
        if not isinstance(info, dict):
            info = {}
        context = int(info.get("max_input_tokens") or 0)
        output = int(info.get("max_output_tokens") or 0)
        cost_input = round(float(info.get("input_cost_per_token") or 0.0) * TOKENS_PER_MILLION, 6)
        cost_output = round(float(info.get("output_cost_per_token") or 0.0) * TOKENS_PER_MILLION, 6)
        models[model_id] = {
            "name": model_id,
            "limit": {"context": context, "output": output},
            "cost": {"input": cost_input, "output": cost_output},
        }
    if not models:
        fail("aucun modele trouve dans le catalogue Mammouth", 2)
    return models


def ollama_models(payload, context, output):
    """Extrait les modeles locaux d'une reponse Ollama (GET /api/tags)."""
    if isinstance(payload, dict):
        entries = payload.get("models")
        if entries is None:
            entries = payload.get("data")
    elif isinstance(payload, list):
        entries = payload
    else:
        entries = None

    models = {}
    if isinstance(entries, list):
        for entry in entries:
            if not isinstance(entry, dict):
                continue
            name = entry.get("name") or entry.get("model")
            if not isinstance(name, str) or not name:
                continue
            models[name] = {
                "name": name,
                "limit": {"context": int(context), "output": int(output)},
                "cost": {"input": 0, "output": 0},
            }
    return models


def parse_args(argv):
    parser = argparse.ArgumentParser(
        prog="update_opencode_mammouth.py",
        description="Fusionne le provider Mammouth AI (et optionnellement "
                    "Ollama) dans la configuration OpenCode.",
    )
    parser.add_argument("--models-file", required=True,
                        help="catalogue JSON Mammouth (local, deja telecharge)")
    parser.add_argument("--config", required=True,
                        help="fichier de configuration OpenCode a modifier")
    parser.add_argument("--ollama-file", default=None,
                        help="reponse JSON de l'API Ollama (/api/tags)")
    parser.add_argument("--ollama-url", default="http://127.0.0.1:11434",
                        help="URL de base du serveur Ollama")
    parser.add_argument("--ollama-context", type=int, default=32768,
                        help="limite de contexte des modeles Ollama")
    parser.add_argument("--ollama-output", type=int, default=8192,
                        help="limite de sortie des modeles Ollama")
    parser.add_argument("--dry-run", action="store_true",
                        help="ne pas ecrire le fichier de configuration")
    return parser.parse_args(argv)


def main(argv=None):
    args = parse_args(argv)

    if args.ollama_context <= 0 or args.ollama_output <= 0:
        fail("--ollama-context et --ollama-output doivent etre positifs", 64)

    generated = mammoth_models(read_json(args.models_file, "catalogue Mammouth"))

    local_models = {}
    ollama_base = normalize_base(args.ollama_url)
    if args.ollama_file:
        local_models = ollama_models(
            read_json(args.ollama_file, "reponse Ollama"),
            args.ollama_context,
            args.ollama_output,
        )
        if not local_models:
            sys.stderr.write(
                "Avertissement: aucun modele local trouve dans %s/api/tags\n"
                % ollama_base)

    config_file = os.path.abspath(args.config)
    if os.path.exists(config_file):
        config = read_json(config_file, "configuration OpenCode")
        if not isinstance(config, dict):
            fail("la configuration OpenCode doit etre un objet JSON", 2)
    else:
        config = {"$schema": CONFIG_SCHEMA}

    providers = config.get("provider")
    if providers is None:
        providers = {}
        config["provider"] = providers
    elif not isinstance(providers, dict):
        fail("le champ 'provider' de la configuration doit etre un objet JSON", 2)

    # Provider Mammouth : les reglages existants (options, env, options par
    # modele) sont conserves ; seul le catalogue de modeles est rafraichi.
    mammouth = providers.get("mammouth")
    mammouth = dict(mammouth) if isinstance(mammouth, dict) else {}
    mammouth["npm"] = OPENAI_COMPATIBLE_NPM
    mammouth["name"] = mammouth.get("name") or "Mammouth AI"
    options = dict(mammouth.get("options") or {})
    options["baseURL"] = options.get("baseURL") or MAMMOUTH_BASE_URL
    mammouth["options"] = options
    env = mammouth.get("env")
    env = list(env) if isinstance(env, list) else []
    if MAMMOUTH_ENV_VAR not in env:
        env.append(MAMMOUTH_ENV_VAR)
    mammouth["env"] = env
    previous = mammouth.get("models")
    previous = previous if isinstance(previous, dict) else {}
    merged = {}
    for model_id, entry in generated.items():
        prior = previous.get(model_id)
        merged_model = dict(prior) if isinstance(prior, dict) else {}
        merged_model.update(entry)
        merged[model_id] = merged_model
    mammouth["models"] = merged
    providers["mammouth"] = mammouth

    # Provider Ollama : existant preserve (options, cle, modeles manuels) ;
    # les modeles locaux decouverts sont ajoutes sans ecraser l'existant.
    ollama_models_map = {}
    if local_models:
        ollama = providers.get("ollama")
        ollama = dict(ollama) if isinstance(ollama, dict) else {}
        ollama.setdefault("npm", OPENAI_COMPATIBLE_NPM)
        ollama.setdefault("name", "Ollama (local)")
        ollama_options = dict(ollama.get("options") or {})
        ollama_options.setdefault("baseURL", ollama_base + "/v1")
        ollama["options"] = ollama_options
        current = ollama.get("models")
        ollama_models_map = dict(current) if isinstance(current, dict) else {}
        for name, entry in local_models.items():
            if name not in ollama_models_map:
                ollama_models_map[name] = entry
        ollama["models"] = ollama_models_map
        providers["ollama"] = ollama

    payload = json.dumps(config, indent=2, ensure_ascii=False, sort_keys=False) + "\n"

    if args.dry_run:
        print("Mode simulation (--dry-run) : aucune ecriture")
        print("Configuration cible : %s" % config_file)
        print("Provider mammouth : %d modeles (couts en USD / million de tokens)"
              % len(merged))
        if local_models:
            print("Provider ollama : %d modeles locaux detectes, %d modeles au total"
                  % (len(local_models), len(ollama_models_map)))
        print("Cle API : definir %s dans l'environnement" % MAMMOUTH_ENV_VAR)
        return 0

    directory = os.path.dirname(config_file)
    os.makedirs(directory, exist_ok=True)
    handle = tempfile.NamedTemporaryFile(
        mode="w", encoding="utf-8", dir=directory, prefix=".opencode.json.tmp.",
        suffix=".json", delete=False)
    temporary = handle.name
    try:
        with handle:
            handle.write(payload)
            handle.flush()
            os.fsync(handle.fileno())
        os.chmod(temporary, 0o600)
        os.replace(temporary, config_file)
    except BaseException:
        try:
            os.unlink(temporary)
        except OSError:
            pass
        raise

    print("Configuration OpenCode mise a jour : %s" % config_file)
    print("Provider mammouth : %d modeles (couts en USD / million de tokens)" % len(merged))
    if local_models:
        print("Provider ollama : %d modeles locaux ajoutes, %d modeles au total"
              % (len(local_models), len(ollama_models_map)))
    print("Cle API : definir %s dans l'environnement (jamais ecrite sur disque)" % MAMMOUTH_ENV_VAR)
    return 0


if __name__ == "__main__":
    sys.exit(main())
