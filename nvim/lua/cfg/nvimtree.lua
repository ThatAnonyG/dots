local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open File"))
	vim.keymap.set("n", "h", api.node.open.edit, opts("Collapse"))
	vim.keymap.set("n", "l", api.node.open.edit, opts("Expand"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open in V-Split"))
	vim.keymap.set("n", "n", api.fs.create, opts("Create new file"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete a file"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut a file"))
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy a file"))
	vim.keymap.set("n", "V", api.fs.paste, opts("Paste a file"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename a file"))
	vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy a filename"))
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy a file path (relative)"))
	vim.keymap.set("n", "<C-y>", api.fs.copy.absolute_path, opts("Copy a file path (absolute)"))
	vim.keymap.set("n", "<C-x>", api.fs.clear_clipboard, opts("Clear clipboard"))
	vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignored"))
	vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Hidden Files"))
end

nvim_tree.setup({
	on_attach = on_attach,
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		side = "left",
		number = false,
		relativenumber = false,
	},
	renderer = {
		highlight_git = true,
		root_folder_label = ":t",
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},
})
