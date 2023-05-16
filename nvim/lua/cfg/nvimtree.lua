local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "<CR>", api.node.open.tab, opts("Open File"))
  vim.keymap.set("n", "h", api.node.open.edit, opts("Collapse"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Expand"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open in V-Split"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename a file"))
  vim.keymap.set("n", "n", api.fs.create, opts("Create new file"))
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
		mappings = {
			custom_only = false,
			list = {
			},
		},
		number = false,
		relativenumber = false,
	},
	renderer = {
		highlight_git = true,
		root_folder_modifier = ":t",
    root_folder_label = false,
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
