local M = {}

M.setup = function()
	local icons = {
		{ name = "DiagnosticSignError", hl = "DiagnosticVirtualTextError", text = "" },
		{ name = "DiagnosticSignWarn", hl = "DiagnosticVirtualTextWarn", text = "" },
		{ name = "DiagnosticSignHint", hl = "DiagnosticVirtualTextHint", text = "" },
		{ name = "DiagnosticSignInfo", hl = "DiagnosticVirtualTextInfo", text = "" },
	}

	for _, icon in ipairs(icons) do
		vim.fn.sign_define(icon.name, { texthl = icon.name, text = icon.text, numhl = icon.name, linehl = icon.hl })
	end

	local config = {
		virtual_text = true,
		signs = {
			active = icons,
		},
		update_in_insert = true,
		underline = false,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]])
	end
end

M.lsp_keymaps = function(bufnr)
	local function build_opts(opts)
		local default_opts = { noremap = true, silent = true }
		for k, v in pairs(opts) do
			default_opts[k] = v
		end
		return default_opts
	end

	local which_key = require("which-key")

	---@cast which_key wk

	---@type wk.Spec
	local leader_mappings = {
		mode = "n",
		buffer = bufnr,
		silent = true,
		noremap = true,
		nowait = true,
		{ "<Leader>l", group = "LSP" },
		{ "<Leader>li", "<cmd>LspInfo<cr>", desc = "LSP Info" },
		{ "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
		{ "<Leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Open diagnostic" },
		{ "<Leader>lj", "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", desc = "Previous diagnostic" },
		{ "<Leader>lk", "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", desc = "Next diagnostic" },
		{ "<Leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Symbol rename" },
		{ "<Leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Symbol search" },
		{ "<Leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Quickfix" },
		{ "g", group = "Go to" },
		{ "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to declaration" },
		{ "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition" },
		{ "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to implementation" },
		{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to references" },
		{ "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
	}

	which_key.add(leader_mappings)

	vim.api.nvim_buf_set_keymap(
		bufnr,
		"i",
		"<C-k>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		build_opts({ desc = "Function signature help" })
	)

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ timeout_ms = 5000 })' ]])
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end

	local status_ok, navic = pcall(require, "nvim-navic")
	if status_ok and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	M.lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Do a protected call to check the LSP plugin for the cmp
local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
