#!/usr/bin/env bash
# =====================================================================
# Dotfiles installer
# Usage : ./install.sh [install|uninstall|reinstall|backup|reset|list|help]
# =====================================================================

set -euo pipefail

# --- Variables ---------------------------------------------------------

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Table: chemin relatif dans le repo → chemin absolu cible
declare -A LINKS=(
    ["nvim"]="$HOME/.config/nvim"
    ["tmux"]="$HOME/.config/tmux"
    ["alacritty"]="$HOME/.config/alacritty"
    ["lazygit"]="$HOME/.config/lazygit"
    ["yazi"]="$HOME/.config/yazi"
    ["starship/starship.toml"]="$HOME/.config/starship.toml"
    ["zsh/.zshrc"]="$HOME/.zshrc"
)

# Dossiers nettoyés lors d'un reset
LOCAL_SHARE_DIRS=(
    "$HOME/.local/share/nvim"
    "$HOME/.local/share/tmux"
)

# --- Couleurs ----------------------------------------------------------

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
RESET='\033[0m'

info()  { echo -e "${GREEN}✓${RESET} $*"; }
warn()  { echo -e "${YELLOW}⚠${RESET}  $*"; }
error() { echo -e "${RED}✗${RESET} $*" >&2; }
step()  { echo -e "${BLUE}→${RESET} $*"; }

# --- Fonctions ---------------------------------------------------------

link_safe() {
    local src="$1"
    local tgt="$2"

    mkdir -p "$(dirname "$tgt")"

    if [[ -L "$tgt" && "$(readlink "$tgt")" == "$src" ]]; then
        info "$tgt déjà lié correctement"
    elif [[ -e "$tgt" || -L "$tgt" ]]; then
        error "$tgt existe déjà (fichier, dossier ou lien existant)"
        error "→ Lancez d'abord 'backup' puis supprimez ce chemin, ou faites un 'reset'"
        exit 1
    else
        ln -s "$src" "$tgt"
        info "Lien créé : $tgt → $src"
    fi
}

unlink_safe() {
    local tgt="$1"
    local expected="$2"

    if [[ -L "$tgt" && "$(readlink "$tgt")" == "$expected" ]]; then
        rm "$tgt"
        info "Lien supprimé : $tgt"
    elif [[ -L "$tgt" ]]; then
        warn "$tgt est un lien mais ne pointe pas vers notre repo, ignoré"
    elif [[ -e "$tgt" ]]; then
        warn "$tgt est un fichier réel, ignoré"
    else
        info "$tgt n'existe pas, rien à faire"
    fi
}

# --- Commandes ---------------------------------------------------------

cmd_install() {
    step "Installation des liens"
    for src_rel in "${!LINKS[@]}"; do
        link_safe "$DOTFILES/$src_rel" "${LINKS[$src_rel]}"
    done
    info "Installation terminée"
}

cmd_uninstall() {
    step "Désinstallation des liens"
    for src_rel in "${!LINKS[@]}"; do
        unlink_safe "${LINKS[$src_rel]}" "$DOTFILES/$src_rel"
    done
    info "Désinstallation terminée"
}

cmd_backup() {
    local backup_dir="$DOTFILES/backups/$(date +%Y%m%d_%H%M%S)"
    step "Backup vers $backup_dir"
    mkdir -p "$backup_dir"

    for src_rel in "${!LINKS[@]}"; do
        local tgt="${LINKS[$src_rel]}"
        if [[ -e "$tgt" || -L "$tgt" ]]; then
            # On reproduit la structure relative dans le backup pour éviter
            # les collisions de noms (ex: deux fichiers nommés "config")
            local backup_path="$backup_dir/$src_rel"
            mkdir -p "$(dirname "$backup_path")"
            cp -rL "$tgt" "$backup_path"
            info "Sauvegardé : $tgt"
        else
            warn "$tgt n'existe pas, ignoré"
        fi
    done

    info "Backup terminé → $backup_dir"
}

cmd_reset() {
    warn "ATTENTION : reset complet. Cela va :"
    warn "  1. Supprimer les symlinks (uninstall)"
    warn "  2. Supprimer les dossiers suivants :"
    for d in "${LOCAL_SHARE_DIRS[@]}"; do
        warn "     - $d"
    done
    echo ""
    read -r -p "Confirmer le reset ? [oui/N] " confirm

    if [[ "$confirm" != "oui" ]]; then
        info "Reset annulé"
        exit 0
    fi

    cmd_uninstall

    step "Suppression des données locales"
    for d in "${LOCAL_SHARE_DIRS[@]}"; do
        if [[ -d "$d" ]]; then
            rm -rf "$d"
            info "Supprimé : $d"
        else
            info "$d n'existe pas, ignoré"
        fi
    done

    info "Reset terminé"
}

cmd_list() {
    echo "Liens configurés :"
    for src_rel in "${!LINKS[@]}"; do
        echo "  - $src_rel → ${LINKS[$src_rel]}"
    done
}

cmd_help() {
    cat <<EOF
Usage: $0 <commande>

Commandes :
  install    Crée tous les symlinks (erreur si conflit)
  uninstall  Supprime tous les symlinks gérés
  reinstall  uninstall + install
  backup     Sauvegarde la config actuelle dans backups/<date>/
  reset      uninstall + suppression des données locales (nvim, tmux)
  list       Liste les liens configurés
  help       Affiche cette aide
EOF
}

# --- Dispatch ----------------------------------------------------------

case "${1:-help}" in
    install)   cmd_install ;;
    uninstall) cmd_uninstall ;;
    reinstall) cmd_uninstall && cmd_install ;;
    backup)    cmd_backup ;;
    reset)     cmd_reset ;;
    list)      cmd_list ;;
    help|-h|--help) cmd_help ;;
    *)
        error "Commande inconnue : $1"
        cmd_help
        exit 1
        ;;
esac
