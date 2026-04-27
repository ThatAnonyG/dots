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
		include = {
			node_type = {
				lua = { "table_constructor", "function_definition", "function_call", "if_statement", "for_statement" },
				go = {
					"composite_literal",
					"func_literal",
					"function_declaration",
					"method_declaration",
					"if_statement",
					"for_statement",
				},
				typescript = { "object", "arrow_function", "function_declaration", "if_statement", "for_statement" },
				javascript = { "object", "arrow_function", "function_declaration", "if_statement", "for_statement" },
			},
		},
	},
})
vim.wo.colorcolumn = "99999"
