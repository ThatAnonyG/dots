local opts = { noremap = true, silent = true } -- general options
local topts = { silent = true } -- terminal options
local keymap = vim.api.nvim_set_keymap -- function alias

-- NORMAL MODE MAPPINGS --

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Open file drawer
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Format document
keymap("n", "<Leader>f", ":Format<CR>", opts)

-- Telescope
keymap(
	"n",
	"<Leader>t",
	"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>",
	opts
)
keymap("n", "<C-g>", "<cmd>lua require('telescope.builtin').git_branches()<CR>", opts)
keymap("n", "<Leader>F", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)

-- Git stuff
keymap("n", "<Leader>b", ":Gitsigns blame_line<CR>", opts)
keymap("n", "<Leader>g", ":lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Close buffers
keymap("n", "<C-w>", ":Bdelete!<CR>", opts)

-- INSERT MODE MAPPINGS --

-- Set escape to 'jj'
keymap("i", "jj", "<ESC>", opts)

-- Disable escape key completely
keymap("i", "<ESC>", "<Nop>", opts)

-- VISUAL MODE MAPPINGS --

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Do not replace copied text
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "<S-j>", ":m '>+1<CR>gv-gv", opts)
keymap("x", "<S-k>", ":m '<-2<CR>gv-gv", opts)

-- TERMINAL MODE MAPPINGS --

-- Terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", topts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", topts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", topts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", topts)
