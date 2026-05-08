-- Load my favorite theme with high prio
-- Theme will be selected bu common.colorscheme

return {
	{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000, opts = {} },
	{ "vague-theme/vague.nvim", lazy = false, priority = 1000, opts = {} },
	{ "rebelot/kanagawa.nvim", lazy = false, priority = 1000, opts = {} },
	{ "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
}
