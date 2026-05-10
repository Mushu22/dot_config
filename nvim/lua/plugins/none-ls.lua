-- Use cppcheck and act like a LSP server for nvim-lsp
-- Need to install cppcheck manualy on system (pacman / apy / ... )
return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- cppcheck pour le C++
				-- implemntation in lull-ls here: https://github.com/nvimtools/none-ls.nvim/blob/main/lua/null-ls/builtins/diagnostics/cppcheck.lua
				null_ls.builtins.diagnostics.cppcheck.with({
					extra_args = {
						"--enable=all", -- active toutes les vérifications
						"--suppress=missingIncludeSystem", -- ignore les includes système manquants
					},
				}),
			},
		})
	end,
}
