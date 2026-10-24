# dot_config — Agent Guidelines

This is a personal dotfiles repository. No build/test/lint pipeline exists. Workflow centers on editing configs and running the installer.

## Repository Structure

```
├── install.sh              # Main entrypoint: manages all symlinks
├── nvim/                   # Neovim config (lua, lazy.nvim)
│   ├── init.lua            # Entry: loads common/* + plugins/*
│   ├── lua/common/         # Core: options, keymaps, autocmds, lazy, colorscheme
│   └── lua/plugins/        # One file per plugin
├── tmux/tmux.conf          # Tmux config (TPM plugins, catppuccin, vim-tmux-navigator)
├── alacritty/              # Terminal config + themes submodule
├── lazygit/config.yml      # LazyGit config
├── yazi/yazi.toml          # Yazi file manager config
├── starship/starship.toml  # Prompt config
├── script/                 # Utilities bash script
└── docs/                   # Keyboard shortcuts, TODO, notes
```

## Key Commands

| Task | Command |
|------|---------|
| Install all symlinks | `./install.sh install` |
| Uninstall (remove symlinks) | `./install.sh uninstall` |
| Reinstall | `./install.sh reinstall` |
| Backup current config | `./install.sh backup` |
| Full reset (symlinks + local data) | `./install.sh reset` |
| List configured links | `./install.sh list` |
| Reload tmux config | `tmux source-file ~/.config/tmux/tmux.conf` or `Leader+R` |
| Reload shell | `source ~/.bashrc` |
| Update Tmux plugins | `Leader+I` in tmux |
| Update Neovim plugins | Open nvim → `:Lazy update` |
| Check Neovim health | `:checkhealth` |

## Symlink Mapping (from `install.sh`)

| Repo Path | Target |
|-----------|--------|
| `nvim/` | `~/.config/nvim` |
| `tmux/` | `~/.config/tmux` |
| `alacritty/` | `~/.config/alacritty` |
| `lazygit/config.yml` | `~/.config/lazygit/config.yml` |
| `yazi/` | `~/.config/yazi` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `bash/.bashrc` | `~/.bashrc` |
| `bash/.bash_profile` | `~/.bash_profile` |

**Reset also removes:** `~/.local/share/nvim`, `~/.local/share/tmux`

## Neovim Specifics

- **Plugin manager:** lazy.nvim (auto-installs on first run)
- **Config style:** Modular — `init.lua` imports `common/*`, lazy loads `plugins/*`
- **Leader key:** `<Space>` (see `lua/common/keymaps.lua`)
- **Key escape:** `jk` exits insert/visual
- **Key plugin groups:** Telescope (`<leader>s*`), LSP (`gd`, `gr`, `<leader>ca`), Git (`<leader>h*`), Neo-tree (`\`), CodeCompanion AI (`<leader>a*`)

## Tmux Specifics

- **Prefix:** `Ctrl+Space` (not `Ctrl+b`)
- **Pane nav:** `Ctrl+h/j/k/l` (smart: passes through to nvim/lazygit)
- **Resize:** `Alt+Arrow`
- **Plugins:** TPM at `~/.local/share/tmux/plugins/` — auto-installs on first run
- **Theme:** catppuccin macchiato, status top

## Alacritty Themes

Themes live in `alacritty/alacritty-theme/themes/` (git submodule). Active theme set via `import` in `alacritty.toml`. Current: `enfocado_dark.toml`.

## Common Gotchas

1. **Symlink conflicts:** `install.sh install` fails if target exists. Run `backup` first, or manually remove.
2. **Font requirement:** `mononoki Nerd Font Mono` must be installed system-wide (see `docs/README.md`).
3. **Color mismatch:** Neovim colors may differ inside/outside tmux — known issue (see `docs/TODO.md`).

## When Editing Configs

- **Neovim:** Edit files in `nvim/lua/plugins/` for plugin config, `nvim/lua/common/` for core behavior.
- **Tmux:** Edit `tmux/tmux.conf` — reload with `Leader+R`.
- **Alacritty:** Edit `alacritty/alacritty.toml` — changes apply on restart.
- **Starship:** Edit `starship/starship.toml` — reload with `starship reload` or restart shell.
- **After changes:** Run `./install.sh reinstall` to refresh symlinks (or just edit the live files in `~/.config/` and copy back).

## References

- `docs/keyboard.md` — Full keymap reference (terminal, tmux, vim, nvim)
- `docs/TODO.md` — Known issues and planned improvements
- `docs/note.md` — Clipboard behavior, learning resources
