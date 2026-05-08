-- Plugin for better integration with tmux
return {
	{
		"aserowy/tmux.nvim",
		opts = {
			resize = {
				-- disable default keybindoing for resize (Alt +hjkl) because Alt + jk, used for line moving
				-- Use keyboard arrows instead
				enable_default_keybindings = false,
			},
		},
		keys = {
			{
				"<A-Left>",
				function()
					require("tmux").resize_left()
				end,
				desc = "Resize left",
			},
			{
				"<A-Right>",
				function()
					require("tmux").resize_right()
				end,
				desc = "Resize right",
			},
			{
				"<A-Up>",
				function()
					require("tmux").resize_top()
				end,
				desc = "Resize up",
			},
			{
				"<A-Down>",
				function()
					require("tmux").resize_bottom()
				end,
				desc = "Resize down",
			},
		},
	},
}
