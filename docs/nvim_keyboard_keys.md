# Raccourcis Clavier pour Neovim

Ce document répertorie les raccourcis clavier disponibles dans votre configuration Neovim, ainsi que les raccourcis de base utiles avec Vim et Neovim.

## Table des Matières

- [Raccourcis de Base](#raccourcis-de-base)
  - [Navigation](#navigation)
  - [Édition de Texte](#édition-de-texte)
  - [Gestion des Fichiers](#gestion-des-fichiers)
  - [Recherche et Remplacement](#recherche-et-remplacement)
  - [Modes](#modes)
  - [Fenêtres et Onglets](#fenêtres-et-onglets)
- [Raccourcis Personnalisés](#raccourcis-personnalisés)
  - [Général](#général)
  - [Navigation entre Fenêtres](#navigation-entre-fenêtres)
  - [Recherche avec Telescope](#recherche-avec-telescope)
  - [Gestion de Git avec Gitsigns](#gestion-de-git-avec-gitsigns)
  - [LSP (Language Server Protocol)](#lsp-language-server-protocol)
  - [Neo-tree](#neo-tree)

## Raccourcis de Base

### Navigation

| Raccourci | Description |
|-----------|-------------|
| `h` | Déplacer le curseur à gauche |
| `j` | Déplacer le curseur vers le bas |
| `k` | Déplacer le curseur vers le haut |
| `l` | Déplacer le curseur à droite |
| `w` | Aller au début du mot suivant |
| `b` | Aller au début du mot précédent |
| `e` | Aller à la fin du mot courant |
| `gg` | Aller au début du fichier |
| `G` | Aller à la fin du fichier |
| `:10` | Aller à la ligne 10 |
| `Ctrl + f` | Faire défiler vers le bas d'une page |
| `Ctrl + b` | Faire défiler vers le haut d'une page |
| `Ctrl + d` | Faire défiler vers le bas d'une demi-page |
| `Ctrl + u` | Faire défiler vers le haut d'une demi-page |

### Édition de Texte

| Raccourci | Description |
|-----------|-------------|
| `i` | Passer en mode insertion avant le curseur |
| `a` | Passer en mode insertion après le curseur |
| `I` | Passer en mode insertion au début de la ligne |
| `A` | Passer en mode insertion à la fin de la ligne |
| `o` | Insérer une nouvelle ligne en dessous |
| `O` | Insérer une nouvelle ligne au-dessus |
| `x` | Supprimer le caractère sous le curseur |
| `dd` | Supprimer la ligne courante |
| `yy` | Copier la ligne courante |
| `p` | Coller après le curseur |
| `P` | Coller avant le curseur |
| `u` | Annuler la dernière action |
| `Ctrl + r` | Rétablir la dernière action annulée |
| `v` | Passer en mode visuel |
| `V` | Passer en mode visuel ligne |
| `Ctrl + v` | Passer en mode visuel bloc |
| `>` | Indenter vers la droite |
| `<` | Indenter vers la gauche |
| `=` | Auto-indenter |

### Gestion des Fichiers

| Raccourci | Description |
|-----------|-------------|
| `:w` | Sauvegarder le fichier |
| `:q` | Quitter le fichier |
| `:wq` | Sauvegarder et quitter |
| `:q!` | Quitter sans sauvegarder |
| `:e <fichier>` | Ouvrir un fichier |
| `:bn` | Aller au buffer suivant |
| `:bp` | Aller au buffer précédent |
| `:bd` | Fermer le buffer courant |

### Recherche et Remplacement

| Raccourci | Description |
|-----------|-------------|
| `/motif` | Rechercher un motif |
| `n` | Aller à l'occurrence suivante |
| `N` | Aller à l'occurrence précédente |
| `:%s/ancien/nouveau/g` | Remplacer toutes les occurrences dans le fichier |
| `:%s/ancien/nouveau/gc` | Remplacer avec confirmation |

### Modes

| Raccourci | Description |
|-----------|-------------|
| `Esc` | Passer en mode normal |
| `i` | Passer en mode insertion |
| `v` | Passer en mode visuel |
| `V` | Passer en mode visuel ligne |
| `Ctrl + v` | Passer en mode visuel bloc |
| `:` | Passer en mode commande |

### Fenêtres et Onglets

| Raccourci | Description |
|-----------|-------------|
| `:split` | Diviser la fenêtre horizontalement |
| `:vsplit` | Diviser la fenêtre verticalement |
| `Ctrl + w + h` | Aller à la fenêtre de gauche |
| `Ctrl + w + j` | Aller à la fenêtre du bas |
| `Ctrl + w + k` | Aller à la fenêtre du haut |
| `Ctrl + w + l` | Aller à la fenêtre de droite |
| `Ctrl + w + =` | Équilibrer la taille des fenêtres |
| `:tabnew` | Ouvrir un nouvel onglet |
| `gt` | Aller à l'onglet suivant |
| `gT` | Aller à l'onglet précédent |

## Raccourcis Personnalisés

### Général

| Raccourci | Description |
|-----------|-------------|
| `<leader>q` | Ouvrir la liste des diagnostics |
| `<Esc>` | Effacer les surlignages de recherche |
| `<Esc><Esc>` | Quitter le mode terminal |

### Navigation entre Fenêtres

| Raccourci | Description |
|-----------|-------------|
| `Ctrl + h` | Aller à la fenêtre de gauche |
| `Ctrl + j` | Aller à la fenêtre du bas |
| `Ctrl + k` | Aller à la fenêtre du haut |
| `Ctrl + l` | Aller à la fenêtre de droite |

### Recherche avec Telescope

| Raccourci | Description |
|-----------|-------------|
| `<leader>sh` | Rechercher dans l'aide |
| `<leader>sk` | Rechercher les raccourcis clavier |
| `<leader>sf` | Rechercher des fichiers |
| `<leader>ss` | Sélectionner un picker Telescope |
| `<leader>sw` | Rechercher le mot courant |
| `<leader>sg` | Rechercher avec grep |
| `<leader>sd` | Rechercher les diagnostics |
| `<leader>sr` | Reprendre la dernière recherche |
| `<leader>s.` | Rechercher les fichiers récents |
| `<leader><leader>` | Trouver les buffers existants |
| `<leader>/` | Rechercher de manière floue dans le buffer courant |
| `<leader>s/` | Rechercher avec grep dans les fichiers ouverts |
| `<leader>sn` | Rechercher dans les fichiers de configuration Neovim |

### Gestion de Git avec Gitsigns

| Raccourci | Description |
|-----------|-------------|
| `]c` | Aller au changement git suivant |
| `[c` | Aller au changement git précédent |
| `<leader>hs` | Stager le hunk (mode visuel) |
| `<leader>hr` | Réinitialiser le hunk (mode visuel) |
| `<leader>hs` | Stager le hunk (mode normal) |
| `<leader>hr` | Réinitialiser le hunk (mode normal) |
| `<leader>hS` | Stager le buffer |
| `<leader>hu` | Annuler le stage du hunk |
| `<leader>hR` | Réinitialiser le buffer |
| `<leader>hp` | Prévisualiser le hunk |
| `<leader>hb` | Blâmer la ligne |
| `<leader>hd` | Diff contre l'index |
| `<leader>hD` | Diff contre le dernier commit |
| `<leader>tb` | Basculer l'affichage du blâme de la ligne |
| `<leader>tD` | Basculer l'affichage des suppressions |

### LSP (Language Server Protocol)

| Raccourci | Description |
|-----------|-------------|
| `gd` | Aller à la définition |
| `gr` | Aller aux références |
| `gI` | Aller à l'implémentation |
| `<leader>D` | Aller à la définition du type |
| `<leader>ds` | Rechercher les symboles du document |
| `<leader>ws` | Rechercher les symboles de l'espace de travail |
| `<leader>rn` | Renommer |
| `<leader>ca` | Action de code |
| `gD` | Aller à la déclaration |
| `<leader>th` | Basculer les indices inlay |

### Neo-tree

| Raccourci | Description |
|-----------|-------------|
| `\` | Ouvrir/Fermer Neo-tree |
