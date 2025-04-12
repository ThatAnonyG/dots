local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

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

---@type wk.Spec
local leader_nmappings = {
	mode = "n",
	silent = true,
	noremap = true,
	nowait = true,
	--- Hidden
	{ "<silent>", hidden = true },
	{ "<cmd>", hidden = true },
	{ "<Cmd>", hidden = true },
	{ "<CR>", hidden = true },
	{ "call", hidden = true },
	{ "lua", hidden = true },
	{ "^:", hidden = true },
	{ "^ ", hidden = true },
	--- Mappings
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

which_key.setup(setup_opts)
which_key.add(leader_nmappings)
