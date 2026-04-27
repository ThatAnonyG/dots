local status_ok, blink = pcall(require, "blink.cmp")
if not status_ok then
	return
end

blink.setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
		["<C-b>"] = { "scroll_documentation_up", "fallback" },
		["<C-f>"] = { "scroll_documentation_down", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	snippets = {
		preset = "default",
	},
	completion = {
		menu = {
			border = "rounded",
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
				components = {
					kind_icon = {
						ellipsis = false,
						text = function(ctx)
							return " " .. ctx.kind_icon .. " "
						end,
						highlight = function(ctx)
							return "BlinkCmpKind" .. ctx.kind
						end,
					},
					kind = {
						ellipsis = false,
						width = { fill = true },
						text = function(ctx)
							return "(" .. ctx.kind .. ")"
						end,
						highlight = function(ctx)
							return "BlinkCmpKind" .. ctx.kind
						end,
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			window = { border = "rounded" },
		},
	},
})

-- Catppuccin-style highlights matching your old cmp colors
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "#C6D0F5", bg = "#181825" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#1e1e2e", fg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = "#43465A", bg = "#74C7EC" })
vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = "#43465A", bg = "#74C7EC" })
vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = "#43465A", bg = "#87B0F9" })
vim.api.nvim_set_hl(0, "BlinkCmpKindValue", { fg = "#43465A", bg = "#87B0F9" })
vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = "#43465A", bg = "#F38BA8" })
vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = "#43465A", bg = "#F38BA8" })
vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = "#43465A", bg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = "#43465A", bg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = "#43465A", bg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = "#43465A", bg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = "#43465A", bg = "#F9E2AF" })
vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = "#43465A", bg = "#F9E2AF" })
vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = "#43465A", bg = "#F5C2E7" })
vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = "#43465A", bg = "#94E2D5" })
vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = "#43465A", bg = "#94E2D5" })
