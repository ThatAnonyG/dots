local M = {}

M.setup = function()
	local icons = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, icon in ipairs(icons) do
		vim.fn.sign_define(icon.name, { texthl = icon.name, text = icon.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = icons,
		},
		update_in_insert = true,
		underline = true,
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
		vim.api.nvim_exec(
			[[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
			false
		)
	end
end

local function lsp_keymaps(bufnr)
	local function build_opts(opts)
		local default_opts = { noremap = true, silent = true }
		for k, v in pairs(opts) do
			default_opts[k] = v
		end
		return default_opts
	end

	local gmappings = {
		g = {
			name = "Go to",
			d = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
			D = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
			r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go to references" },
			k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show function info" },
		},
	}

	require("which-key").register(gmappings, {
		mode = "n",
		buffer = bufnr,
		silent = true,
		noremap = true,
		nowait = true,
	})

	local mappings = {
		l = {
			name = "LSP",
			a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Open diagnostic" },
			j = { "<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>", "Next diagnostic" },
			k = { "<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>", "Previous diagnostic" },
			q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quick fix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		},
	}
	require("which-key").register(mappings, {
		mode = "n",
		prefix = "<Leader>",
		buffer = bufnr,
		silent = true,
		noremap = true,
		nowait = true,
	})

	vim.api.nvim_buf_set_keymap(
		bufnr,
		"i",
		"<C-k>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		build_opts({ desc = "Function signature help" })
	)

	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]])
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.documentFormattingProvider = false
	end
	if client.name == "lua_ls" then
		client.server_capabilities.documentFormattingProvider = false
	end
	lsp_keymaps(bufnr)
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