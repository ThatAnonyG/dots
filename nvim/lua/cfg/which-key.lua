local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

---@cast which_key wk

---@type wk.Opts
local setup_opts = {
	plugins = {
		marks = false,
		registers = false,
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			nav = false,
			z = false,
		},
	},
	layout = {
		spacing = 5,
	},
	---@param mapping wk.Mapping
	filter = function(mapping)
		if mapping.desc and mapping.desc ~= "" then
			return true
		end
		return false
	end,
}
which_key.setup(setup_opts)

---@type wk.Spec
local hidden = {
	mode = "n",
	silent = true,
	noremap = true,
	nowait = true,
	{ "<silent>", hidden = true },
	{ "<cmd>", hidden = true },
	{ "<Cmd>", hidden = true },
	{ "<CR>", hidden = true },
	{ "call", hidden = true },
	{ "lua", hidden = true },
	{ "^:", hidden = true },
	{ "^ ", hidden = true },
}
which_key.add(hidden)

-- Unmap ESC in insert mode
which_key.add({
	mode = "i",
	noremap = true,
	silent = true,
	{ "jj", "<ESC>", desc = "Use jj as ESC" },
	{ "<ESC>", "<Nop>", desc = "Unmap ESC" },
})

-- Copilot
which_key.add({
	"<C-j>",
	'copilot#Accept("<CR>")',
	mode = "i",
	noremap = false,
	expr = true,
	silent = true,
	replace_keycodes = false,
	desc = "Accept Copilot",
})

-- Comment
which_key.add({
	"<C-_>",
	'<cmd>lua require("Comment.api").toggle.linewise.current()<CR>',
	mode = "i",
	desc = "Toggle comment",
})
which_key.add({
	"<C-_>",
	function()
		vim.api.nvim_feedkeys(esc, "nx", false)
		require("Comment.api").toggle.linewise(vim.fn.visualmode())
	end,
	mode = "x",
	desc = "Toggle comment",
})

-- Buffer navigation
which_key.add({
	mode = "n",
	silent = true,
	noremap = true,
	{ "<S-Tab>", "<cmd>bprevious<CR>", desc = "Previous file in tab" },
	{ "<Tab>", "<cmd>bnext<CR>", desc = "Next file in tab" },
})

---@type wk.Spec
local leader_nmappings = {
	mode = "n",
	silent = true,
	noremap = true,
	nowait = true,
	{ "<Leader><Leader>", "<cmd>WhichKey<CR>", desc = "Open which-key" },
	{ "<Leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
	{ "<Leader>a", "<cmd>Alpha<CR>", desc = "Dashboard" },
	{
		"<Leader>f",
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false, "
			.. "file_ignore_patterns = {'.git/', '.cache', '%.o', '%.a', '%.out', '%.class', '%.pdf', '%.mkv', '%.mp4', '%.zip'}"
			.. (jit.os == "Windows" and "" or ", hidden = true")
			.. " }))<CR>",
		desc = "Find files",
	},
	{ "<Leader>p", "<cmd>Telescope projects<CR>", desc = "Projects" },
	{ "<Leader>g", group = "Git" },
	{ "<Leader>gg", "<cmd>!tmux neww lazygit<CR>", desc = "Lazygit" },
	{ "<Leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<CR>", desc = "Blame" },
	{ "<Leader>go", "<cmd>Telescope git_status<CR>", desc = "Open changed file" },
	{ "<Leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Checkout branch" },
	{ "<Leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Checkout commit" },
	{ "<Leader>gd", "<cmd>Gitsigns diffthis HEAD<CR>", desc = "Diff" },
	{ "<Leader>s", group = "Search" },
	{ "<Leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<CR>", desc = "Search globally" },
	{ "<Leader>b", group = "Buffer" },
	{
		"<Leader>bb",
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
		desc = "Open buffers",
	},
	{ "<Leader>bf", "<cmd>Format<CR>", desc = "Format document" },
	{ "<Leader>bc", "<cmd>w | Bdelete!<CR>", desc = "Close file" },
	{ "<Leader>bq", "<cmd>Bdelete!<CR>", desc = "Close file (no save)" },
	{ "<Leader>bh", "<cmd>nohlsearch<CR>", desc = "No Highlight" },
}
which_key.add(leader_nmappings)

---@type wk.Spec
local ctrl_nmappings = {
	mode = "n",
	silent = true,
	noremap = true,
	nowait = true,
	-- Window navigation
	{ "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Window left" },
	{ "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Window down" },
	{ "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Window up" },
	{ "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Window right" },
	-- Save with CTRL-S
	{ "<C-s>", "<cmd>w<CR>", desc = "Save file" },
}
which_key.add(ctrl_nmappings)

---@type wk.Spec
local vmappings = {
	mode = "v",
	silent = true,
	noremap = true,
	nowait = true,
	-- Snapshot code
	{ "<Leader>sc", "<cmd>Silicon<CR>", desc = "Snapshot code" },
	-- Stay in indent mode
	{ "<", "<gv", desc = "Indent block to left" },
	{ ">", ">gv", desc = "Indent block to right" },
	-- Do not replace copied text
	{ "p", '"_dP' },
}
which_key.add(vmappings)
