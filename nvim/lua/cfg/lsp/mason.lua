local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

local servers = {
  "lua_ls",
  "jsonls",
  "tsserver",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 5,
}

mason.setup(settings)
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lsp_config_status_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_config_status_ok then
  return
end

local opts = {}
local lsp_handlers = "cfg.lsp.handlers"

for _, server in pairs(servers) do
  opts = {
    on_attach = require(lsp_handlers).on_attach,
    capablities = require(lsp_handlers).capablities,
  }

  server = vim.split(server, "@")[1]

  local lspsettings_status_ok, lspsettings = pcall(require, "cfg.lsp.settings." .. server)
  if lspsettings_status_ok then
    opts = vim.tbl_deep_extend("force", lspsettings, opts)
  end

  lspconfig[server].setup(opts)
end

