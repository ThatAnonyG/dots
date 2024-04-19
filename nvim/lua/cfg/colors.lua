local colorscheme = "catppuccin"

if colorscheme == "catppuccin" then
	require(colorscheme).setup({
		transparent_background = false,
	})
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
	vim.notify("Warning: Colorscheme " .. colorscheme .. " not found!")
	return
end
