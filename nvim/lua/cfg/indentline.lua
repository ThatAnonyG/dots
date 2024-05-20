local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
	return
end

ibl.setup({
	exclude = {
		buftypes = { "terminal", "nofile" },
		filetypes = {
			"help",
			"startify",
			"dashboard",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
		},
	},
	indent = { char = "▏" },
	scope = {
		show_start = true,
		show_end = false,
	},
})
vim.wo.colorcolumn = "99999"
