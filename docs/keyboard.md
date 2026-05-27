# Raccourcis Clavier

Ce document répertoire les raccourcis clavier pour le terminal, Tmux, Neovim et Vim.

**Légende :**
- ✓ = Raccourci natif (Vim/Terminal)
- ✦ = Raccourci personnalisé (configuré dans votre dotfiles)

## Table des Matières

- [Terminal / Shell](#terminal--shell)
- [Tmux](#tmux)
- [Vim](#vim)
  - [Movement](#movement)
  - [Scroll](#scroll)
  - [Jump](#jump)
  - [Mode Insert](#mode-insert)
  - [Édition](#édition)
  - [Mode Visual](#mode-visual)
  - [Macros](#macros)
  - [Fichiers](#fichiers)
  - [Recherche](#recherche)
  - [Modes](#modes)
  - [Fenêtres](#fenêtres)
- [NVIM - Personnalisés](#nvim---personnalisés)
  - [Général](#général)
  - [Which-key](#which-key)
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

## Vim

### Movement

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

### Scroll

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Ctrl + f` | Page down | ✓ |
| `Ctrl + b` | Page up | ✓ |
| `Ctrl + d` | Demi-page down | ✓ |
| `Ctrl + u` | Demi-page up | ✓ |

### Jump

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Ctrl + o` | Jump précédent | ✓ |
| `Ctrl + i` | Jump suivant | ✓ |
| `f/F <char>` | Rechercher caractère avant/arrière | ✓ |
| `t/T <char>` | Aller jusqu'au caractère | ✓ |

### Mode Insert

| Raccourci | Description | Type |
|-----------|-------------|------|
| `i` | Insert avant curseur | ✓ |
| `a` | Insert après curseur | ✓ |
| `I` | Insert début de ligne | ✓ |
| `A` | Insert fin de ligne | ✓ |
| `o` | Nouvelle ligne dessous | ✓ |
| `O` | Nouvelle ligne dessus | ✓ |

### Édition

| Raccourci | Description | Type |
|-----------|-------------|------|
| `x` | Supprimer caractère | ✓ |
| `dd` | Supprimer ligne | ✓ |
| `yy` | Copier ligne | ✓ |
| `p` | Coller après | ✓ |
| `P` | Coller avant | ✓ |
| `u` | Undo | ✓ |
| `Ctrl + r` | Redo | ✓ |
| `D` | Supprimer fin de ligne | ✓ |
| `Y` | Copier fin de ligne | ✓ |
| `c` | Changer | ✓ |
| `cc` | Changer ligne | ✓ |

### Mode Visual

| Raccourci | Description | Type |
|-----------|-------------|------|
| `v` | Mode visuel | ✓ |
| `V` | Mode visuel ligne | ✓ |
| `Ctrl + v` | Mode visuel bloc | ✓ |
| `<` | Indenter à gauche (visual) | ✦ |
| `>` | Indenter à droite (visual) | ✦ |
| `=` | Auto-indenter | ✓ |

### Macros

| Raccourci | Description | Type |
|-----------|-------------|------|
| `q<register>` | Enregistrer macro (ex: `qr`) | ✓ |
| `q` | Arrêter enregistrement | ✓ |
| `@<register>` | Exécuter macro (ex: `@r`) | ✓ |
| `5@r` | Exécuter 5 fois | ✓ |

### Fichiers

| Raccourci | Description | Type |
|-----------|-------------|------|
| `:w` | Sauvegarder | ✓ |
| `:q` | Quitter | ✓ |
| `:wq` | Sauvegarder et quitter | ✓ |
| `:q!` | Quitter sans sauvegarde | ✓ |
| `:e <fichier>` | Ouvrir fichier | ✓ |
| `:bn` | Buffer suivant | ✓ |
| `:bp` | Buffer précédent | ✓ |
| `:bd` | Fermer buffer | ✓ |

### Recherche

| Raccourci | Description | Type |
|-----------|-------------|------|
| `/motif` | Rechercher | ✓ |
| `n` | Occurrence suivante | ✓ |
| `N` | Occurrence précédente | ✓ |
| `:%s/old/new/g` | Remplacer tout | ✓ |
| `:%s/old/new/gc` | Remplacer avec confirm | ✓ |

### Modes

| Raccourci | Description | Type |
|-----------|-------------|------|
| `Esc` | Mode normal | ✓ |
| `i` | Mode insertion | ✓ |
| `v` | Mode visuel | ✓ |
| `V` | Mode visuel ligne | ✓ |
| `Ctrl + v` | Mode visuel bloc | ✓ |

### Commandes / Terminal

| Raccourci | Description | Type |
|-----------|-------------|------|
| `:` | Mode commande | ✓ |
| `:!` | Run terminal commande | ✓ |
| `!!` | Insert terminal commande | ✓ |

### Fenêtres

| Raccourci | Description | Type |
|-----------|-------------|------|
| `:split` | Split horizontal | ✓ |
| `:vsplit` | Split vertical | ✓ |
| `Ctrl + w + s` | Split horizontal | ✓ |
| `Ctrl + w + v` | Split vertical | ✓ |
| `Ctrl + w + h` | Fenêtre gauche | ✓ |
| `Ctrl + w + j` | Fenêtre bas | ✓ |
| `Ctrl + w + k` | Fenêtre haut | ✓ |
| `Ctrl + w + l` | Fenêtre droite | ✓ |
| `Ctrl + w + =` | Équilibrer | ✓ |
| `:tabnew` | Nouvel onglet | ✓ |
| `gt` | Onglet suivant | ✓ |
| `gT` | Onglet précédent | ✓ |

## NVIM - Personnalisés

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
