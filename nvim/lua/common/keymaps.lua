--  NOTE: ':luafile %' -> reload current file

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

-- ESCAPE --

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- use "²" as Escape
vim.keymap.set("i", "²", "<Esc>")
vim.keymap.set("n", "²", "<Esc>")
vim.keymap.set("v", "²", "<Esc>")
vim.keymap.set("n", "²", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Exit from insert and visual mode with jk
vim.keymap.set("i", "jk", "<Esc>", { desc = "Quick exit Inser mode" })
vim.keymap.set("v", "jk", "<Esc>", { desc = "Quick exit Visual mode" })

-- Stay in indentation mode using < and >
vim.keymap.set("v", "<", "<gv", { desc = "Left indent visual" })
vim.keymap.set("v", ">", ">gv", { desc = "Right indent visual" })

-- Alt + j or k , move text
--function used to set keymap with soilent mode enabled by default
--silent mode make no display on the bottom bar
local silent_keymap = function(mode, lhs, rhs, opts)
	opts = opts or {}
	opts.silent = opts.silent ~= false
	opts.noremap = true
	vim.keymap.set(mode, lhs, rhs, opts)
end

silent_keymap("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move line Up" })
silent_keymap("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line Down" })

silent_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines Up" })
silent_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines Down" })

-- Disable new yanking if paste on visual mode
vim.keymap.set("v", "p", '"_dP')

-- call my custom colorscheme selector
local colorscheme = require("common.colorscheme")
vim.keymap.set("n", "<leader>u", colorscheme.select, { desc = "Select UI theme" })
