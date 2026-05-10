#!/usr/bin/env bash
# =====================================================================
# Dotfiles installer
# Usage : ./install.sh [install|uninstall|reinstall|backup|reset|list|help]
# =====================================================================

set -euo pipefail

# --- Variables ---------------------------------------------------------

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="$HOME"
XDG_DIR="$HOME/.config"

XDG_PACKAGES=(nvim tmux alacritty lazygit yazi)

declare -A HOME_FILES=(
    ["zsh/.zshrc"]=".zshrc"
)

# Dossiers créés par les outils dans ~/.local/share, nettoyés lors du reset
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
    step "Installation des packages XDG"
    for pkg in "${XDG_PACKAGES[@]}"; do
        link_safe "$DOTFILES/$pkg" "$XDG_DIR/$pkg"
    done

    step "Installation des fichiers HOME"
    for src_rel in "${!HOME_FILES[@]}"; do
        local tgt_name="${HOME_FILES[$src_rel]}"
        link_safe "$DOTFILES/$src_rel" "$HOME_DIR/$tgt_name"
    done

    info "Installation terminée"
}

cmd_uninstall() {
    step "Désinstallation des packages XDG"
    for pkg in "${XDG_PACKAGES[@]}"; do
        unlink_safe "$XDG_DIR/$pkg" "$DOTFILES/$pkg"
    done

    step "Désinstallation des fichiers HOME"
    for src_rel in "${!HOME_FILES[@]}"; do
        local tgt_name="${HOME_FILES[$src_rel]}"
        unlink_safe "$HOME_DIR/$tgt_name" "$DOTFILES/$src_rel"
    done

    info "Désinstallation terminée"
}

cmd_backup() {
    local backup_dir="$DOTFILES/backups/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    step "Création du backup dans $backup_dir"

    for pkg in "${XDG_PACKAGES[@]}"; do
        local tgt="$XDG_DIR/$pkg"
        if [[ -e "$tgt" || -L "$tgt" ]]; then
            # -rL : copie récursive en suivant les symlinks (on veut les fichiers réels)
            cp -rL "$tgt" "$backup_dir/$pkg"
            info "Sauvegardé : $tgt"
        else
            warn "$tgt n'existe pas, ignoré"
        fi
    done

    for src_rel in "${!HOME_FILES[@]}"; do
        local tgt_name="${HOME_FILES[$src_rel]}"
        local tgt="$HOME_DIR/$tgt_name"
        if [[ -e "$tgt" || -L "$tgt" ]]; then
            cp -rL "$tgt" "$backup_dir/$tgt_name"
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
    echo "Packages XDG  (→ ~/.config/) :"
    for pkg in "${XDG_PACKAGES[@]}"; do
        echo "  - $pkg"
    done
    echo "Fichiers HOME (→ ~) :"
    for src_rel in "${!HOME_FILES[@]}"; do
        echo "  - $src_rel → ~/${HOME_FILES[$src_rel]}"
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
  list       Liste les packages configurés
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
