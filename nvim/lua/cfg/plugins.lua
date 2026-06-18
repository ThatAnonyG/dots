-- Install lazy for plugin managementplu
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim",
		"--branch=stable",
		lazypath,
	})
	print("Installing lazy. Please restart Neovim!")
end

vim.opt.rtp:prepend(lazypath)

-- Remap the leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use protected to avoid error
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

-- Add all plugins here
lazy.setup({
	-- Useful plugins
	"nvim-lua/plenary.nvim", -- utils lib used as a dependency
	"lewis6991/gitsigns.nvim", -- git support
	"nvim-tree/nvim-tree.lua", -- file explorer
	"akinsho/bufferline.nvim", -- nice looking bufferline
	"moll/vim-bbye", -- for bufferline
	"christoomey/vim-tmux-navigator", -- tmux integration
	"nvim-tree/nvim-web-devicons", -- cool icons
	{ "nvim-mini/mini.nvim", version = "*" }, -- icons for mini.nvim
	"nvim-lualine/lualine.nvim", -- cool status line
	"folke/which-key.nvim", -- keybindings
	"folke/snacks.nvim", -- snacks

	-- Themes
	{ "catppuccin/nvim", name = "catppuccin" },

	-- CMP Plugins
	{
		"saghen/blink.cmp",
		build = function()
			require("blink.cmp").build():wait(60000)
		end,
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
		},
	},

	-- LSP and Language Plugins
	"neovim/nvim-lspconfig", -- enable the LSP
	{ "mason-org/mason.nvim" }, -- GUI installer for language servers
	{ "mason-org/mason-lspconfig.nvim" }, -- LSP config for mason
	"nvimtools/none-ls.nvim", -- for formatters and linters
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag", -- html tag auto closing
			"nvim-treesitter/nvim-treesitter-context", -- context based highlighting
		},
	}, -- syntax highlighter
	"rafamadriz/friendly-snippets", -- community snippets
	"SmiteshP/nvim-navic", -- winbar context outline

	-- Debugging
	"jay-babu/mason-nvim-dap.nvim", -- mason for nvim-dap
	"mfussenegger/nvim-dap", -- debugging
	"leoluz/nvim-dap-go", -- debugging for go
	"nvim-neotest/nvim-nio", -- neotest for lua
	"rcarriga/nvim-dap-ui", -- UI for nvim-dap
	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
	{ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }, -- JS debugging

	-- Telescope
	"nvim-telescope/telescope.nvim", -- Telescope plugin
	"nvim-telescope/telescope-media-files.nvim", -- Telescope extension to view media files

	-- Utility Plugins
	"HiPhish/rainbow-delimiters.nvim", -- rainbow brackets
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- indentation lines
	"windwp/nvim-autopairs", -- auto close brackets and quotes
	{
		"github/copilot.vim",
		config = function()
			vim.cmd([[ highlight CopilotSuggestion guifg=#555555 ctermfg=8 ]])
		end,
	}, -- github copilot
	"NvChad/nvim-colorizer.lua", -- color code highlighter
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
	}, -- code to image
	"sindrets/diffview.nvim", -- diff view for git
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	}, -- colored comments
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
	}, -- better folding
})
