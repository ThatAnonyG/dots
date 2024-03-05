-- Protected require for cmp plugin
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

-- Protected require for luasnip plugin
local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
	return
end

-- Lazy load luasnip stuff
require("luasnip/loaders/from_vscode").lazy_load()

-- Util func for checking backspace
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- Icon list
local nerd_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- Actual cmp setup
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- disables a mapping
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local lspkind = require("lspkind")
			local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local srings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (srings[1] or "") .. " "
			kind.menu = "     (" .. (srings[2] or "") .. ")"
			return kind
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "crates" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered(),
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

-- Customization for Pmenu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#1e1e2e", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C6D0F5", bg = "#181825" })
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#43465A", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#87B0F9", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#87B0F9", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#CBA6F7", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#43465A", bg = "#74C7EC" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#43465A", bg = "#74C7EC" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#43465A", bg = "#87B0F9" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#43465A", bg = "#87B0F9" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#43465A", bg = "#87B0F9" })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#43465A", bg = "#F38BA8" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#43465A", bg = "#F38BA8" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#43465A", bg = "#F38BA8" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#43465A", bg = "#A6E3A1" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#43465A", bg = "#A6E3A1" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#43465A", bg = "#A6E3A1" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#43465A", bg = "#F9E2AF" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#43465A", bg = "#F9E2AF" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#43465A", bg = "#F9E2AF" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#43465A", bg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#43465A", bg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#43465A", bg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#43465A", bg = "#CBA6F7" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#43465A", bg = "#CBA6F7" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#43465A", bg = "#F5C2E7" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#43465A", bg = "#F5C2E7" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#43465A", bg = "#F5C2E7" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#43465A", bg = "#94E2D5" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#43465A", bg = "#94E2D5" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#43465A", bg = "#94E2D5" })
