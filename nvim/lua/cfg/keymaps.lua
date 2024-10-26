local function build_opts(opts)
	local default_opts = { noremap = true, silent = true }
	for k, v in pairs(opts) do
		default_opts[k] = v
	end
	return default_opts
end

local keymap = vim.api.nvim_set_keymap -- function alias
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

---------------------
--- CTRL MAPPINGS ---
---------------------

-- Copilot accept
keymap("i", "<C-j>", 'copilot#Accept("<CR>")', build_opts({ noremap = false, expr = true }))

-- Toggle comment on a line
keymap(
	"i",
	"<C-_>",
	'<cmd>lua require("Comment.api").toggle.linewise.current()<CR>',
	build_opts({ desc = "Toggle comment" })
)

-- Toggle comment on a line
vim.keymap.set("x", "<C-_>", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, build_opts({ desc = "Toggle comment" }))

-- Window navigation
keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", build_opts({ desc = "Window left" }))
keymap("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", build_opts({ desc = "Window down" }))
keymap("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", build_opts({ desc = "Window up" }))
keymap("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", build_opts({ desc = "Window right" }))

-- Save with CTRL-S
keymap("n", "<C-s>", "<cmd>w<CR>", build_opts({ desc = "Save file" }))

----------------------
--- SHIFT MAPPINGS ---
----------------------

-- Move text up and down
keymap("n", "<M-j>", "<cmd>m .+1<CR>==", build_opts({ desc = "Move line down" }))
keymap("n", "<M-k>", "<cmd>m .-2<CR>==", build_opts({ desc = "Move line up" }))

-- Stay in indent mode
keymap("v", "<", "<gv", build_opts({ desc = "Indent block to left" }))
keymap("v", ">", ">gv", build_opts({ desc = "Indent block to right" }))

-----------------------
--- GENERAL MAPPINGS ---
-----------------------

-- Quit stuff with q
vim.cmd([[
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
]])

-- Open whichkey window
keymap("n", "<Leader><Leader>", "<cmd>WhichKey<CR>", build_opts({ desc = "Whichkey menu" }))

-- Do not replace copied text
keymap("v", "p", '"_dP', build_opts({}))

-- Escape insert mode
keymap("i", "jj", "<ESC>", build_opts({}))
keymap("i", "<ESC>", "<Nop>", build_opts({}))

-- Buffer navigation
keymap("n", "<S-Tab>", "<cmd>bprevious<CR>", build_opts({ desc = "Previous file in tab" }))
keymap("n", "<Tab>", "<cmd>bnext<CR>", build_opts({ desc = "Next file in tab" }))

-- Snapping code
keymap("v", "<Leader>sc", ":Silicon<CR>", build_opts({ desc = "Snapshot code" }))
