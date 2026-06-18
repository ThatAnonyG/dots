local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
	return
end

vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"

ufo.setup()

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		require("ufo").attach(args.buf)
	end,
})
