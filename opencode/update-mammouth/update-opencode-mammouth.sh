#!/usr/bin/env bash
#
# update-opencode-mammouth.sh
#
# Met a jour la configuration OpenCode (~/.config/opencode/opencode.json) :
#   * provider "mammouth" : @ai-sdk/openai-compatible, baseURL
#     https://api.mammouth.ai/v1, cle API lue dans la variable d'environnement
#     MAMMOUTH_API_KEY (jamais ecrite sur disque) ;
#   * provider "ollama" (optionnel) : modeles locaux decouverts via
#     GET <ollama-url>/api/tags.
#
# Source du catalogue Mammouth (au choix) :
#   * --url URL       : catalogue JSON telecharge avec curl (defaut :
#     https://api.mammouth.ai/public/models) ;
#   * --models-file P : catalogue JSON local.
#
# La fusion JSON de la configuration est realisee par
# update_opencode_mammouth.py, place a cote de ce script.
#
# Exemples :
#   ./update-opencode-mammouth.sh
#   ./update-opencode-mammouth.sh --url http://127.0.0.1:8000/mammouth_models.json
#   ./update-opencode-mammouth.sh --models-file ./mammouth_models.json
#   ./update-opencode-mammouth.sh --ollama --ollama-url http://127.0.0.1:11434
#   ./update-opencode-mammouth.sh --dry-run
#
# Dependances : bash, python3, et curl (pour le telechargement du catalogue
# et/ou l'appel de l'API Ollama).
#
set -euo pipefail

PROGRAM_NAME="${0##*/}"

DEFAULT_MODELS_URL="https://api.mammouth.ai/public/models"
MODELS_URL="${MAMMOUTH_MODELS_URL:-$DEFAULT_MODELS_URL}"
MODELS_FILE="${MAMMOUTH_MODELS_FILE:-}"
CONFIG_FILE=""
WITH_OLLAMA="0"
OLLAMA_URL="${OLLAMA_HOST:-http://127.0.0.1:11434}"
OLLAMA_CONTEXT="32768"
OLLAMA_OUTPUT="8192"
DOWNLOAD_TIMEOUT="30"
OLLAMA_TIMEOUT="5"
DRY_RUN="0"

URL_CLI="0"
FILE_CLI="0"
FILE_ENV="0"
if [ -n "${MAMMOUTH_MODELS_FILE:-}" ]; then
  FILE_ENV="1"
fi

usage() {
  cat <<EOF
Usage: $PROGRAM_NAME [options]

Met a jour la configuration OpenCode avec le provider Mammouth AI et,
optionnellement, avec les modeles locaux d'un serveur Ollama.

Source du catalogue Mammouth (URL par defaut) :
  --url URL              URL du catalogue JSON Mammouth, telecharge avec curl
                         (defaut : $DEFAULT_MODELS_URL)
  --models-file PATH     Catalogue JSON Mammouth local. Utilise seul (sans
                         --url) : le catalogue local est lu directement, sans
                         telechargement. Utilise avec --url : sert de repli
                         EXPLICITE si le telechargement echoue (un avertissement
                         est alors affiche). Sans --models-file, un echec de
                         telechargement est une erreur claire et rien n'est ecrit.

Options :
  --config PATH          Fichier de configuration OpenCode a modifier
                         (defaut : \$OPENCODE_CONFIG, sinon \$HOME/.config/opencode/opencode.json)
  --ollama               Decouvrir les modeles locaux via l'API Ollama et les
                         ajouter au provider "ollama" (sans toucher aux
                         modeles declares manuellement)
  --ollama-url URL       URL du serveur Ollama (defaut : \$OLLAMA_HOST ou http://127.0.0.1:11434)
  --ollama-context N     Limite de contexte des modeles Ollama (defaut : $OLLAMA_CONTEXT)
  --ollama-output N      Limite de sortie des modeles Ollama (defaut : $OLLAMA_OUTPUT)
  --ollama-timeout N     Delai du serveur Ollama, en secondes (defaut : $OLLAMA_TIMEOUT)
  --download-timeout N   Delai de telechargement du catalogue, en secondes (defaut : $DOWNLOAD_TIMEOUT)
  --dry-run              Affiche le resultat sans ecrire le fichier de configuration
  -h, --help             Afficher cette aide

Variables d'environnement :
  MAMMOUTH_MODELS_URL    Equivalent de --url
  MAMMOUTH_MODELS_FILE   Catalogue local par defaut (equivalent de --models-file
                         lorsqu'aucune --url n'est fournie ; n'active pas le repli
                         apres echec d'un telechargement)
  OPENCODE_CONFIG        Equivalent de --config
  OLLAMA_HOST            Equivalent de --ollama-url
  MAMMOUTH_API_KEY       Cle API Mammouth (lue par OpenCode, jamais ecrite sur disque)

La fusion JSON est realisee par update_opencode_mammouth.py, cherche a cote
de ce script (reperage via dirname + readlink -f).
EOF
}

die() {
  local message="$1"
  local code="${2:-1}"
  printf 'Erreur: %s\n' "$message" >&2
  exit "$code"
}

need_value() {
  # $1 = nom de l'option, $2 = nombre d'arguments restants
  if [ "$2" -lt 2 ]; then
    die "$1 requiert une valeur" 64
  fi
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --url)
      need_value "$1" "$#"
      MODELS_URL="$2"; URL_CLI="1"; shift 2 ;;
    --url=*)
      MODELS_URL="${1#*=}"; URL_CLI="1"; shift ;;
    --models-file)
      need_value "$1" "$#"
      MODELS_FILE="$2"; FILE_CLI="1"; shift 2 ;;
    --models-file=*)
      MODELS_FILE="${1#*=}"; FILE_CLI="1"; shift ;;
    --config)
      need_value "$1" "$#"
      CONFIG_FILE="$2"; shift 2 ;;
    --config=*)
      CONFIG_FILE="${1#*=}"; shift ;;
    --ollama)
      WITH_OLLAMA="1"; shift ;;
    --ollama-url)
      need_value "$1" "$#"
      OLLAMA_URL="$2"; shift 2 ;;
    --ollama-url=*)
      OLLAMA_URL="${1#*=}"; shift ;;
    --ollama-context)
      need_value "$1" "$#"
      OLLAMA_CONTEXT="$2"; shift 2 ;;
    --ollama-context=*)
      OLLAMA_CONTEXT="${1#*=}"; shift ;;
    --ollama-output)
      need_value "$1" "$#"
      OLLAMA_OUTPUT="$2"; shift 2 ;;
    --ollama-output=*)
      OLLAMA_OUTPUT="${1#*=}"; shift ;;
    --ollama-timeout)
      need_value "$1" "$#"
      OLLAMA_TIMEOUT="$2"; shift 2 ;;
    --ollama-timeout=*)
      OLLAMA_TIMEOUT="${1#*=}"; shift ;;
    --download-timeout)
      need_value "$1" "$#"
      DOWNLOAD_TIMEOUT="$2"; shift 2 ;;
    --download-timeout=*)
      DOWNLOAD_TIMEOUT="${1#*=}"; shift ;;
    --dry-run)
      DRY_RUN="1"; shift ;;
    -h|--help)
      usage; exit 0 ;;
    *)
      printf 'Erreur: option inconnue: %s\n' "$1" >&2
      usage >&2
      exit 64 ;;
  esac
done

# --- Reperage du script Python associe -----------------------------------
SCRIPT_PATH="$(readlink -f -- "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname -- "$SCRIPT_PATH")"
PYTHON_SCRIPT="$SCRIPT_DIR/update_opencode_mammouth.py"
[ -f "$PYTHON_SCRIPT" ] || die "script Python associe introuvable a cote de $PROGRAM_NAME: $PYTHON_SCRIPT" 2

# --- Verifications des dependances ----------------------------------------
command -v python3 >/dev/null 2>&1 || die "python3 est requis mais n'est pas installe" 1

# --- Selection de la source du catalogue Mammouth --------------------------
# Priorite : options de la ligne de commande > variables d'environnement >
#            URL par defaut.
#   --url seul                  -> telechargement depuis l'URL
#   --models-file seul          -> lecture locale (aucun telechargement)
#   URL + fichier local fournis -> telechargement ; en cas d'echec, repli
#                                  EXPLICITE (avertissement) sur le fichier
#                                  local s'il existe.
#   URL seule en echec          -> erreur claire, aucune ecriture.
if [ "$URL_CLI" = "1" ]; then
  SOURCE_MODE="url"
elif [ "$FILE_CLI" = "1" ]; then
  SOURCE_MODE="file"
elif [ -n "${MAMMOUTH_MODELS_URL:-}" ]; then
  SOURCE_MODE="url"
elif [ "$FILE_ENV" = "1" ]; then
  SOURCE_MODE="file"
else
  SOURCE_MODE="url"
fi

NEED_CURL="0"
if [ "$SOURCE_MODE" = "url" ]; then
  NEED_CURL="1"
fi
if [ "$WITH_OLLAMA" = "1" ]; then
  NEED_CURL="1"
fi
if [ "$NEED_CURL" = "1" ]; then
  command -v curl >/dev/null 2>&1 || die "curl est requis mais n'est pas installe" 1
fi

# --- Resolution de la configuration OpenCode ------------------------------
if [ -z "$CONFIG_FILE" ]; then
  if [ -n "${OPENCODE_CONFIG:-}" ]; then
    CONFIG_FILE="$OPENCODE_CONFIG"
  else
    CONFIG_FILE="${HOME}/.config/opencode/opencode.json"
  fi
fi

# --- Fichiers temporaires -------------------------------------------------
TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf -- "$TMP_DIR"
}
trap cleanup EXIT

# --- Source du catalogue Mammouth -----------------------------------------
MODELS_PATH=""
if [ "$SOURCE_MODE" = "file" ]; then
  [ -f "$MODELS_FILE" ] || die "catalogue Mammouth introuvable: $MODELS_FILE" 2
  MODELS_PATH="$MODELS_FILE"
  SOURCE_LABEL="fichier local ($MODELS_FILE)"
else
  if curl -fsS --connect-timeout 10 --max-time "$DOWNLOAD_TIMEOUT" \
       "$MODELS_URL" -o "$TMP_DIR/models.json"; then
    [ -s "$TMP_DIR/models.json" ] || die "catalogue Mammouth vide telecharge depuis $MODELS_URL" 3
    MODELS_PATH="$TMP_DIR/models.json"
    SOURCE_LABEL="URL ($MODELS_URL)"
  else
    if [ "$FILE_CLI" = "1" ] && [ -f "$MODELS_FILE" ]; then
      printf 'Avertissement: telechargement du catalogue Mammouth en echec (%s) ; repli EXPLICITE sur le fichier local %s\n' \
        "$MODELS_URL" "$MODELS_FILE" >&2
      MODELS_PATH="$MODELS_FILE"
      SOURCE_LABEL="fichier local ($MODELS_FILE ; repli explicite apres echec du telechargement de $MODELS_URL)"
    else
      die "telechargement du catalogue Mammouth impossible: $MODELS_URL (utilisez --models-file pour un catalogue local)" 3
    fi
  fi
fi

# --- Ollama (optionnel) ---------------------------------------------------
OLLAMA_FILE=""
OLLAMA_BASE=""
if [ "$WITH_OLLAMA" = "1" ]; then
  OLLAMA_BASE="${OLLAMA_URL%/}"
  case "$OLLAMA_BASE" in
    http://*|https://*) ;;
    *) OLLAMA_BASE="http://$OLLAMA_BASE" ;;
  esac
  OLLAMA_ENDPOINT="$OLLAMA_BASE/api/tags"
  if ! curl -fsS --connect-timeout "$OLLAMA_TIMEOUT" --max-time "$OLLAMA_TIMEOUT" \
       "$OLLAMA_ENDPOINT" -o "$TMP_DIR/ollama.json"; then
    die "impossible de contacter le serveur Ollama: $OLLAMA_ENDPOINT" 3
  fi
  [ -s "$TMP_DIR/ollama.json" ] || die "reponse vide du serveur Ollama: $OLLAMA_ENDPOINT" 3
  OLLAMA_FILE="$TMP_DIR/ollama.json"
fi

# --- Appel du script Python ----------------------------------------------
PY_ARGS=(
  --models-file "$MODELS_PATH"
  --config "$CONFIG_FILE"
  --ollama-url "$OLLAMA_BASE"
  --ollama-context "$OLLAMA_CONTEXT"
  --ollama-output "$OLLAMA_OUTPUT"
)
if [ "$WITH_OLLAMA" = "1" ]; then
  PY_ARGS+=(--ollama-file "$OLLAMA_FILE")
fi
if [ "$DRY_RUN" = "1" ]; then
  PY_ARGS+=(--dry-run)
fi

printf 'Source du catalogue Mammouth : %s\n' "$SOURCE_LABEL"
python3 "$PYTHON_SCRIPT" "${PY_ARGS[@]}"
