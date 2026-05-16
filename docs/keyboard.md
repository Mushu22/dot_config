# Raccourcis Clavier

Ce document répertoire les raccourcis clavier pour le terminal, Tmux, Neovim et Vim.

**Légende :**
- ✓ = Raccourci natif (Vim/Terminal)
- ✦ = Raccourci personnalisé (configuré dans votre dotfiles)

## Table des Matières

- [Terminal / Shell](#terminal--shell)
- [Tmux](#tmux)
- [NVIM - Raccourcis de Base](#nvim---raccourcis-de-base)
  - [Navigation](#navigation)
  - [Édition de Texte](#édition-de-texte)
  - [Gestion des Fichiers](#gestion-des-fichiers)
  - [Recherche et Remplacement](#recherche-et-remplacement)
  - [Modes](#modes)
  - [Fenêtres et Onglets](#fenêtres-et-onglets)
- [NVIM - Raccourcis Personnalisés](#nvim---raccourcis-personnalisés)
  - [Général](#général)
  - [Navigation entre Fenêtres](#navigation-entre-fenêtres)
  - [Recherche avec Telescope](#recherche-avec-telescope)
  - [Gestion de Git avec Gitsigns](#gestion-de-git-avec-gitsigns)
  - [LSP (Language Server Protocol)](#lsp-language-server-protocol)
  - [Neo-tree](#neo-tree)

## Terminal / Shell

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Ctrl + p` | Commande précédente | ✓ |
| `Ctrl + n` | Commande suivante | ✓ |
| `Ctrl + a` | Début de ligne | ✓ |
| `Ctrl + e` | Fin de ligne | ✓ |
| `Ctrl + b` | Reculer d'un caractère | ✓ |
| `Ctrl + f` | Avancer d'un caractère | ✓ |
| `Alt + b` | Reculer d'un mot | ✓ |
| `Alt + f` | Avancer d'un mot | ✓ |
| `Ctrl + d` | Supprimer le caractère | ✓ |
| `Ctrl + w` | Supprimer le mot précédent | ✓ |
| `Ctrl + u` | Supprimer la ligne | ✓ |
| ~~`Ctrl + k`~~ | ~~Supprimer jusqu'à la fin de la ligne~~ ⚠️ conflict avec NVIM | ✓ |
| `Ctrl + y` | Coller (yank) | ✓ |
| `Ctrl + r` | Rechercher dans l'historique | ✓ |
| `Ctrl + l` | Effacer le terminal | ✓ |
| `Ctrl + z` | Mettre en arrière-plan (fg pour revenir) | ✓ |
| `Ctrl + c` | Arrêter le processus | ✓ |
| `Ctrl + s` | Pauser | ✓ |
| `Ctrl + q` | Reprendre | ✓ |

## Tmux

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Ctrl + space` | Prefix (remplace Ctrl + b par défaut) | ✦ |
| `v` | Entrer en mode copie (remplace [) | ✦ |

### Sessions & Fenêtres

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Leader + $` | Renommer la session | ✓ |
| `Leader + ,` | Renommer la fenêtre | ✓ |
| `Leader + w` | Lister les fenêtres | ✓ |
| `Leader + &` | Fermer la fenêtre | ✓ |

### Navigation entre Panneaux

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Ctrl + h` | Aller au panneau de gauche | ✦ |
| `Ctrl + j` | Aller au panneau du bas | ✦ |
| `Ctrl + k` | Aller au panneau du haut | ✦ |
| `Ctrl + l` | Aller au panneau de droite | ✦ |

### Redimensionner les Panneaux

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Alt + ←` | Redimensionner vers la gauche | ✦ |
| `Alt + ↓` | Redimensionner vers le bas | ✦ |
| `Alt + ↑` | Redimensionner vers le haut | ✦ |
| `Alt + →` | Redimensionner vers la droite | ✦ |

### Split

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Leader + "` | Split horizontal (garde le cwd) | ✦ |
| `Leader + %` | Split vertical (garde le cwd) | ✦ |

### Divers

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Leader + R` | Recharger la config tmux | ✦ |
| `Leader + I` | Installer les plugins (TPM) | ✓ |
| `Leader + Ctrl-s` | Sauvegarder la session (tmux-resurrect) | ✓ |
| `Leader + Ctrl-r` | Restaurer la session (tmux-resurrect) | ✓ |

## NVIM - Raccourcis de Base

### Navigation

| Raccourci | Description | Type |
|-----------|-------------|------|
| `h` | Déplacer le curseur à gauche | ✓ |
| `j` | Déplacer le curseur vers le bas | ✓ |
| `k` | Déplacer le curseur vers le haut | ✓ |
| `l` | Déplacer le curseur à droite | ✓ |
| `w` | Aller au début du mot suivant | ✓ |
| `b` | Aller au début du mot précédent | ✓ |
| `e` | Aller à la fin du mot courant | ✓ |
| `gg` | Aller au début du fichier | ✓ |
| `G` | Aller à la fin du fichier | ✓ |
| `:10` | Aller à la ligne 10 | ✓ |
| `Ctrl + f` | Faire défiler vers le bas d'une page | ✓ |
| `Ctrl + b` | Faire défiler vers le haut d'une page | ✓ |
| `Ctrl + d` | Faire défiler vers le bas d'une demi-page | ✓ |
| `Ctrl + u` | Faire défiler vers le haut d'une demi-page | ✓ |
| `Ctrl + o` | Aller au jump précédent | ✓ |
| `Ctrl + i` | Aller au jump suivant | ✓ |
| `f/F <char>` | Rechercher un caractère vers l'avant/arrière dans la ligne | ✓ |
| `t/T <char>` | Aller jusqu'à un caractère vers l'avant/arrière | ✓ |

### Édition de Texte

| Raccourci | Description | Type |
|-----------|-------------|------|
| `i` | Passer en mode insertion avant le curseur | ✓ |
| `a` | Passer en mode insertion après le curseur | ✓ |
| `I` | Passer en mode insertion au début de la ligne | ✓ |
| `A` | Passer en mode insertion à la fin de la ligne | ✓ |
| `o` | Insérer une nouvelle ligne en dessous | ✓ |
| `O` | Insérer une nouvelle ligne au-dessus | ✓ |
| `x` | Supprimer le caractère sous le curseur | ✓ |
| `dd` | Supprimer la ligne courante | ✓ |
| `yy` | Copier la ligne courante | ✓ |
| `p` | Coller après le curseur | ✓ |
| `P` | Coller avant le curseur | ✓ |
| `u` | Annuler la dernière action | ✓ |
| `Ctrl + r` | Rétablir la dernière action annulée | ✓ |
| `v` | Passer en mode visuel | ✓ |
| `V` | Passer en mode visuel ligne | ✓ |
| `Ctrl + v` | Passer en mode visuel bloc | ✓ |
| `>` | Indenter vers la droite | ✦ |
| `<` | Indenter vers la gauche | ✦ |
| `=` | Auto-indenter | ✓ |
| `D` | Supprimer jusqu'à la fin de la ligne | ✓ |
| `Y` | Copier jusqu'à la fin de la ligne | ✓ |
| `c` | Changer (supprimer et passer en insertion) | ✓ |
| `cc` | Changer la ligne entière | ✓ |
| `<A-j>` | Déplacer les lignes sélectionnées vers le bas | ✦ |
| `<A-k>` | Déplacer les lignes sélectionnées vers le haut | ✦ |

### Macros

| Raccourci | Description | Type |
|-----------|-------------|------|
| `q<register>` | Enregistrer une macro (ex: `qr`) | ✓ |
| `q` | Arrêter l'enregistrement | ✓ |
| `@<register>` | Exécuter une macro (ex: `@r`) | ✓ |
| `5@r` | Exécuter la macro `r` 5 fois | ✓ |

### Gestion des Fichiers

| Raccourci | Description | Type |
|-----------|-------------|------|
| `:w` | Sauvegarder le fichier | ✓ |
| `:q` | Quitter le fichier | ✓ |
| `:wq` | Sauvegarder et quitter | ✓ |
| `:q!` | Quitter sans sauvegarder | ✓ |
| `:e <fichier>` | Ouvrir un fichier | ✓ |
| `:bn` | Aller au buffer suivant | ✓ |
| `:bp` | Aller au buffer précédent | ✓ |
| `:bd` | Fermer le buffer courant | ✓ |

### Recherche et Remplacement

| Raccourci | Description | Type |
|-----------|-------------|------|
| `/motif` | Rechercher un motif | ✓ |
| `n` | Aller à l'occurrence suivante | ✓ |
| `N` | Aller à l'occurrence précédente | ✓ |
| `:%s/ancien/nouveau/g` | Remplacer toutes les occurrences dans le fichier | ✓ |
| `:%s/ancien/nouveau/gc` | Remplacer avec confirmation | ✓ |

### Modes

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Esc` | Passer en mode normal | ✓ |
| `i` | Passer en mode insertion | ✓ |
| `v` | Passer en mode visuel | ✓ |
| `V` | Passer en mode visuel ligne | ✓ |
| `Ctrl + v` | Passer en mode visuel bloc | ✓ |
| `:` | Passer en mode commande | ✓ |

### Fenêtres et Onglets

| Raccourci | Description | Type |
|-----------|-------------|------|
| `:split` | Diviser la fenêtre horizontalement | ✓ |
| `:vsplit` | Diviser la fenêtre verticalement | ✓ |
| `Ctrl + w + s` | Split horizontal | ✓ |
| `Ctrl + w + v` | Split vertical | ✓ |
| `Ctrl + w + h` | Aller à la fenêtre de gauche | ✓ |
| `Ctrl + w + j` | Aller à la fenêtre du bas | ✓ |
| `Ctrl + w + k` | Aller à la fenêtre du haut | ✓ |
| `Ctrl + w + l` | Aller à la fenêtre de droite | ✓ |
| `Ctrl + w + =` | Équilibrer la taille des fenêtres | ✓ |
| `:tabnew` | Ouvrir un nouvel onglet | ✓ |
| `gt` | Aller à l'onglet suivant | ✓ |
| `gT` | Aller à l'onglet précédent | ✓ | |

## NVIM - Raccourcis Personnalisés

### Général

| Raccourci | Description | Type |
|-----------|-------------|------|
| `<leader>q` | Ouvrir la liste des diagnostics | ✦ |
| `<Esc>` | Effacer les surlignages de recherche | ✦ |
| `<Esc><Esc>` | Quitter le mode terminal | ✦ |
| `²` | Escape (AZERTY) | ✦ |
| `jk` | Quitter mode insertion/visual | ✦ |
| `<C-s>` | Sauvegarder le fichier | ✦ |
| `<leader>u` | Sélectionner le thème | ✦ |
| `<A-j>` | Déplacer la ligne vers le bas | ✦ |
| `<A-k>` | Déplacer la ligne vers le haut | ✦ |

### Which-key (Groupes)

| Raccourci | Description | Type |
|-----------|-------------|------|
| `<leader>c` | [C]ode | ✦ |
| `<leader>d` | [D]ocument | ✦ |
| `<leader>r` | [R]ename | ✦ |
| `<leader>s` | [S]earch | ✦ |
| `<leader>t` | [T]oggle | ✦ |

### Navigation entre Fenêtres

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Ctrl + h` | Aller à la fenêtre de gauche | ✦ |
| `Ctrl + j` | Aller à la fenêtre du bas | ✦ |
| `Ctrl + k` | Aller à la fenêtre du haut | ✦ |
| `Ctrl + l` | Aller à la fenêtre de droite | ✦ |

### Recherche avec Telescope

| Raccourci | Description | Type |
|-----------|-------------|------|
| `<leader>sh` | Rechercher dans l'aide | ✦ |
| `<leader>sk` | Rechercher les raccourcis clavier | ✦ |
| `<leader>sf` | Rechercher des fichiers | ✦ |
| `<leader>ss` | Sélectionner un picker Telescope | ✦ |
| `<leader>sw` | Rechercher le mot courant | ✦ |
| `<leader>sg` | Rechercher avec grep | ✦ |
| `<leader>sd` | Rechercher les diagnostics | ✦ |
| `<leader>sr` | Reprendre la dernière recherche | ✦ |
| `<leader>s.` | Rechercher les fichiers récents | ✦ |
| `<leader><leader>` | Trouver les buffers existants | ✦ |
| `<leader>/` | Rechercher de manière floue dans le buffer courant | ✦ |
| `<leader>s/` | Rechercher avec grep dans les fichiers ouverts | ✦ |
| `<leader>sn` | Rechercher dans les fichiers de configuration Neovim | ✦ |

### Gestion de Git avec Gitsigns

| Raccourci | Description | Type |
|-----------|-------------|------|
| `]c` | Aller au changement git suivant | ✦ |
| `[c` | Aller au changement git précédent | ✦ |
| `<leader>hs` | Stager le hunk (mode visuel) | ✦ |
| `<leader>hr` | Réinitialiser le hunk (mode visuel) | ✦ |
| `<leader>hs` | Stager le hunk (mode normal) | ✦ |
| `<leader>hr` | Réinitialiser le hunk (mode normal) | ✦ |
| `<leader>hS` | Stager le buffer | ✦ |
| `<leader>hu` | Annuler le stage du hunk | ✦ |
| `<leader>hR` | Réinitialiser le buffer | ✦ |
| `<leader>hp` | Prévisualiser le hunk | ✦ |
| `<leader>hb` | Blâmer la ligne | ✦ |
| `<leader>hd` | Diff contre l'index | ✦ |
| `<leader>hD` | Diff contre le dernier commit | ✦ |
| `<leader>tb` | Basculer l'affichage du blâme de la ligne | ✦ |
| `<leader>tD` | Basculer l'affichage des suppressions | ✦ |

### LSP (Language Server Protocol)

| Raccourci | Description | Type |
|-----------|-------------|------|
| `gd` | Aller à la définition | ✦ |
| `gr` | Aller aux références | ✦ |
| `gI` | Aller à l'implémentation | ✦ |
| `<leader>D` | Aller à la définition du type | ✦ |
| `<leader>ds` | Rechercher les symboles du document | ✦ |
| `<leader>ws` | Rechercher les symboles de l'espace de travail | ✦ |
| `<leader>rn` | Renommer | ✦ |
| `<leader>ca` | Action de code | ✦ |
| `gD` | Aller à la déclaration | ✦ |
| `<leader>th` | Basculer les indices inlay | ✦ |

### Neo-tree

| Raccourci | Description | Type |
|-----------|-------------|------|
| `\` | Ouvrir/Fermer Neo-tree | ✦ |