## nvim

# kickstart config
https://github.com/nvim-lua/kickstart.nvim

# lua
https://learnxinyminutes.com/docs/lua/
:help lua-guide
https://neovim.io/doc/user/lua-guide.html

# nvim from scratch playlist
https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ

# nvim help
: Tutor
: help xxxx
<space>sh xxxx

# checkhealth
:checkhealth

# idea of plugins from kickstart
- nvim-autopairs
- nvim-dap + ui nio ... (debug)
- indent-blankline
- nvim-lint

## clipboard

# Linux :
	Primary : (select terminal) , paste with midle click
	Secondary : ??
	Clipboard : Ctrl + C / Ctrl + V / Ctrl + Shift + V
	autre:

# copy nvim with clipboard = 'unamedplus'
	Clipboard : "+
	Primary : "*

	"+ / clipboard -> y/p
	"* / primary -> Shift Insert

# past outside vim : 
	in linux console : "*
	ctrl+V : "+

# coller:
    terminal
        Shift + Insert : Primary
        Ctrl + Shift + V : Clipboard
        Molette : Clipboard

    firefox
        Shift + Insert: clipboard
        Ctrl + Shift + V: clipboard
        Ctrl + V: clipboard
        Molette : primary

    nvim
        Shift + Insert : primary
        Ctrl + Shift + V: clipboard
        Molette: clipboard
        p : registre vim

# copie:
    nvim:
        yank/delete: clipboard

    terminal:
        slection souris : clipboard + primary

    tmux viusal:
        enter : clipboard

    firefox:
        Ctrl + C : Clipboard + primary


