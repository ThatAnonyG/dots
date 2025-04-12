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
	layout = {
		spacing = 5,
	},
	filter = function(mapping)
		if mapping.desc and mapping.desc ~= "" then
			return true
		end
		return false
	end,
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
}

local nmappings = {
	["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
	["a"] = { "<cmd>Alpha<CR>", "Dashboard" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false, "
			.. "file_ignore_patterns = {'.git/', '.cache', '%.o', '%.a', '%.out', '%.class', '%.pdf', '%.mkv', '%.mp4', '%.zip'}"
			.. (jit.os == "Windows" and "" or ", hidden = true")
			.. " }))<CR>",
		"Find files",
	},
	["p"] = { "<cmd>Telescope projects<CR>", "Projects" },
	g = {
		name = "Git",
		g = { "<cmd>!tmux neww lazygit<CR>", "Lazygit" },
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
	},
	b = {
		name = "Buffer",
		b = {
			"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
			"Open buffers",
		},
		f = { "<cmd>Format<CR>", "Format document" },
		c = { "<cmd>w | Bdelete!<CR>", "Close file" },
		q = { "<cmd>Bdelete!<CR>", "Close file (no save)" },
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
