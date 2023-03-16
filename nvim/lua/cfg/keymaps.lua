local function build_opts(opts)
	local default_opts = { noremap = true, silent = true }
	for k, v in pairs(opts) do
		default_opts[k] = v
	end
	return default_opts
end

local keymap = vim.api.nvim_set_keymap -- function alias

---------------------
--- CTRL MAPPINGS ---
---------------------

keymap("i", "<C-j>", 'copilot#Accept("<CR>")', build_opts({ noremap = false, expr = true }))
keymap(
	"i",
	"<C-/",
	'<cmd>lua require("Comment.api").toggle_current_linewise()<CR>',
	build_opts({ desc = "Toggle comment" })
)
keymap("x", "<C-r>", ":SearchBoxReplace visual_mode=true<CR>", build_opts({ desc = "Replace in file" }))

----------------------
--- SHIFT MAPPINGS ---
----------------------

-- Move text up and down
keymap("x", "<S-j>", ":m '>+1<CR>gv-gv", build_opts({ desc = "Move line down" }))
keymap("x", "<S-k>", ":m '<-2<CR>gv-gv", build_opts({ desc = "Move line up" }))

-- Stay in indent mode
keymap("v", "<", "<gv", build_opts({ desc = "Indent block to left" }))
keymap("v", ">", ">gv", build_opts({ desc = "Indent block to right" }))

-----------------------
--- LEADER MAPPINGS ---
-----------------------

-- General mappings
vim.cmd([[
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
]])
keymap("n", "<Leader><Leader>", ":WhichKey<CR>", build_opts({ desc = "Whichkey menu" }))
keymap("n", ":", "<cmd>FineCmdline<CR>", build_opts({ desc = "Floating Neovim cmdline" }))

-- Do not replace copied text
keymap("v", "p", '"_dP', build_opts({}))

-- Escape insert mode
keymap("i", "jj", "<ESC>", build_opts({}))
keymap("i", "<ESC>", "<Nop>", build_opts({}))
