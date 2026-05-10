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
			-- key Ctrl + hjkl defined here in order to force lazy loading when these keys are pressed
			{
				"<C-h>",
				function()
					require("tmux").move_left()
				end,
				desc = "Go to left pane",
			},
			{
				"<C-j>",
				function()
					require("tmux").move_bottom()
				end,
				desc = "Go to bottom pane",
			},
			{
				"<C-k>",
				function()
					require("tmux").move_top()
				end,
				desc = "Go to top pane",
			},
			{
				"<C-l>",
				function()
					require("tmux").move_right()
				end,
				desc = "Go to right pane",
			},
		},
	},
}
