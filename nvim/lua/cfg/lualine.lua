local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

lualine.setup({
	options = {
		theme = "catppuccin",
		icons_enabled = true,
		disabled_filetypes = { "dashboard", "Outline" },
	},
	extensions = { "nvim-tree", "nvim-dap-ui" },
})
