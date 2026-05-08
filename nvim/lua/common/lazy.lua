-- [[ Install `lazy.nvim` plugin manager ]]

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

-- use vim function to get data path: ~/.local/share/nvim (:echo stdpath('data'))
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field

-- Add lazy.nvim directory to the runtimepath, list of directory where require looks for plugins
-- :echo nvim_list_runtime_paths()
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

require("lazy").setup({
	-- Here is where you install your plugins.
	-- The import below automatically add your own plugins, configuration, etc from `lua/plugins/*.lua`
	--    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	{ import = "plugins" },

	-- NOTE: plugins install and configuration
	-- Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	-- Plugins can also be added by using a table with the first argument being the link
	-- and the following keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to force a plugin to be loaded.
})
