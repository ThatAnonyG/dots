-- Do a protected call to check for null-ls plugin
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local lsp_handlers = require("cfg.lsp.handlers")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_filetypes = { "svelte" } }),
		formatting.stylua,
		formatting.black,
		formatting.shfmt.with({ extra_filetypes = { "bash" } }),
		diagnostics.markdownlint,
	},
	on_attach = lsp_handlers.on_attach,
})
