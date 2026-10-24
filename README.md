# Overview of dot_config

This repo contains my personal settings for working environment
- terminal
- shell
- nvim
- tmux
- yazi
- lazygit

# Manual setup needed

## tools to install
git, gitk, alacritty, tmux, vim, nvim, fdfind, ack, xclip, python, yazi, fzf, tree, fd, lazygit, tmuxinator, opencode, starship

## bash local config
```
# create local bash
touch ~/.bash.local
```

## font
Used font is mononoki from nerd font website : https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Mononoki.zip
Should be installed in font directory of the system
Cmd to check if well installed :
```
fc-match "mononoki Nerd Font Mono"
```
Font is configured in the terminal alacritty config
Other font to try :
inconsolata, ubuntu, JetBrains, Agave, ...

## Install
Script to use to install symlinks
```
install.sh install
```

# Refresh environements

## bash and tmux

```
source ~/.bashrc
```

## tmux

```
# <tmux-leader> + R (Reload) 
tmux source-file ~/.config/tmux/tmux.conf
# <tmux-leader I> (Update plugins)
```

## nvim
`:Lazy update` : Update plugins
`:checkhealth` : check health

# Docs

## Key map

All common key maps configured are listed in [keyboard.md](./docs/keyboard.md)

