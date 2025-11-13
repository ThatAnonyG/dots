-- Do a protected call to check for LSP Plugin
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("cfg.lsp.mason")
require("cfg.lsp.handlers").setup()
require("cfg.lsp.null-ls")

-- Servers directly using lspconfig can be configured here
local lsp_handlers = require("cfg.lsp.handlers")
local servers = { "nixd" }

for _, server in pairs(servers) do
	local opts = {
		on_attach = lsp_handlers.on_attach,
		capablities = lsp_handlers.capablities,
	}

	local lspsettings_status_ok, lspsettings = pcall(require, "cfg.lsp.settings." .. server)
	if lspsettings_status_ok then
		opts = vim.tbl_deep_extend("force", lspsettings, opts)
	end

	local lspconfig = require("lspconfig")
	lspconfig[server].setup(opts)
end
