local CS_selector = {}

CS_selector.themes = {
	"kanagawa-dragon",
	"vague",
	"tokyonight-night",
	"catppuccin-mocha",
	"kanagawa-wave",
	"tokyonight-storm",
	"tokyonight-moon",
	"catppuccin-macchiato",
	"catppuccin-frappe",
	"kanagawa-lotus",
	"tokyonight-day",
	"catppuccin-latte",
}

CS_selector.current = "kanagawa-wave"

function CS_selector.apply(name)
	name = name or CS_selector.current

	local ok, err = pcall(vim.cmd.colorscheme, name)
	if not ok then
		vim.notify("Failed to load theme: " .. name)
		return
	end

	CS_selector.current = name
end

function CS_selector.select()
	vim.ui.select(CS_selector.themes, {
		prompt = "Select colorscheme:",
	}, function(choice)
		if choice then
			CS_selector.apply(choice)
		end
	end)
end

return CS_selector
