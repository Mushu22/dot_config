-- Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- cette branche ne supporte pas le lazy-loading
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			-- Équivalent de ensure_installed (installation asynchrone)
			ts.install({
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			})

			-- Équivalent de highlight.enable + indent.enable + auto_install
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match)
					if not lang then
						return
					end

					-- Équivalent de auto_install : installe le parseur s'il manque, puis démarre
					local function start()
						if not vim.api.nvim_buf_is_valid(ev.buf) then
							return
						end
						-- Highlight
						if pcall(vim.treesitter.start, ev.buf, lang) then
							-- Indent (équivalent de indent = { enable = true }), sauf ruby
							if lang ~= "ruby" then
								vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
							end
						end
					end

					local installed = ts.get_installed()
					if vim.tbl_contains(installed, lang) then
						start()
					elseif vim.tbl_contains(ts.get_available(), lang) then
						ts.install(lang):await(start)
					end
				end,
			})
		end,
	},
}
