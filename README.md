# dot_config
This repo contains my personal settings for working environment
- terminal
- shell
- vim

## tools to install 
git, gitk, alacritty, zsh, oh-my-zsh, tmux, vim, nvim, fdfind, ack, xclip, python, yazi, fzf, tree,

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
First thing to synchronize submodule
```
git init submodule
```

Backup if needed previous configs, and remove them
```
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.config/tmux
rm -rf ~/.config/alacritty
```

Then create symbolik link to point this direcorty
```
# If dot_config in $HOME:
ln -s $HOME/dot_config/alacritty ~/.config/alacritty
ln -s $HOME/dot_config/nvim ~/.config/nvim
ln -s $HOME/dot_config/tmux ~/.config/tmux
```

For ZSH First install it with curl standard method, and then creat symlink with zshrc
```
# install oh-my-zsh from https://ohmyz.sh/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc
ln -s $HOME/dot_config/zsh/zshrc ~/.zshrc
```

