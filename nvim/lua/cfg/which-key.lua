local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

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
	key_labels = {
		["<leader>"] = "Space",
		["<space>"] = "Space",
		["<cr>"] = "Enter",
		["<tab>"] = "Tab",
	},
	layout = {
		spacing = 5,
	},
	ignore_missing = true,
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
}

local nmappings = {
	["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
	["a"] = { "<cmd>Alpha<CR>", "Dashboard" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false"
			.. (jit.os == "Windows" and "" or ", hidden = true")
			.. " }))<CR>",
		"Find files",
	},
	["p"] = { "<cmd>Telescope projects<CR>", "Projects" },
	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
		o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<CR>",
			"Diff",
		},
	},
	s = {
		name = "Search",
		g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Search globally" },
		s = { "<cmd>SearchBoxIncSearch<CR>", "Find in file" },
		r = { "<cmd>SearchBoxReplace<CR>", "Replace in file" },
	},
	b = {
		name = "Buffer",
		b = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
			"Open buffers",
		},
		f = { "<cmd>Format<CR>", "Format document" },
		h = { "<cmd>bprevious<CR>", "Previous file in tab" },
		l = { "<cmd>bnext<CR>", "Next file in tab" },
		c = { "<cmd>w | Bdelete!<CR>", "Close file" },
		q = { "<cmd>Bdelete!<CR>", "Close file (no save)" },
	},
	t = {
		name = "Terminal",
		f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
	},
}

which_key.setup(setup_opts)
which_key.register(nmappings, {
	mode = "n",
	prefix = "<Leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})
