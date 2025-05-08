-- Install lazy for plugin management
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
	"nvim-lua/popup.nvim", -- popup stuff in nvim
	"nvim-lua/plenary.nvim", -- utils lib used as a dependency
	"lewis6991/gitsigns.nvim", -- git support
	"kyazdani42/nvim-tree.lua", -- file explorer
	"akinsho/bufferline.nvim", -- nice looking bufferline
	"moll/vim-bbye", -- for bufferline
	"christoomey/vim-tmux-navigator", -- tmux integration
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			notify.setup({
				render = "compact",
				background_colour = "FloatShadow",
				timeout = 3000,
			})
			vim.notify = notify
		end,
	}, -- fancy notifications
	"nvim-tree/nvim-web-devicons", -- cool icons
	{ "echasnovski/mini.icons", version = "*" }, -- icons for mini.nvim
	"nvim-lualine/lualine.nvim", -- cool status line
	"ahmedkhalf/project.nvim", -- easily access projects
	{
		"lewis6991/impatient.nvim",
		config = function()
			local impatient = require("impatient")
			impatient.enable_profile()
		end,
	}, -- improve load times
	"goolord/alpha-nvim", -- startup dashboard
	"folke/which-key.nvim", -- keybindings

	-- Themes
	"joshdick/onedark.vim", -- onedark color scheme
	"folke/tokyonight.nvim", -- tokyonight color scheme
	{ "catppuccin/nvim", name = "catppuccin" },

	-- CMP Plugins
	"hrsh7th/nvim-cmp", -- completion plugin
	"hrsh7th/cmp-buffer", -- buffer completion
	"hrsh7th/cmp-path", -- path completion
	"hrsh7th/cmp-cmdline", -- cmdline completion
	"hrsh7th/cmp-nvim-lsp", -- completion for LSPs
	"hrsh7th/cmp-nvim-lua", -- completion for LUA
	"saadparwaiz1/cmp_luasnip", -- snippet completion
	"onsails/lspkind.nvim", -- lsp icons

	-- LSP and Language Plugins
	"neovim/nvim-lspconfig", -- enable the LSP
	{ "mason-org/mason.nvim", version = "1.11.0" }, -- GUI installer for language servers
	{ "mason-org/mason-lspconfig.nvim", version = "1.32.0" }, -- LSP config for mason
	"nvimtools/none-ls.nvim", -- for formatters and linters
	"leafOfTree/vim-svelte-plugin", -- support for svelte
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "windwp/nvim-ts-autotag" },
	}, -- syntax highlighter
	"L3MON4D3/LuaSnip", -- snippet engine
	"rafamadriz/friendly-snippets", -- community snippets
	"SmiteshP/nvim-navic", -- winbar context outline

	-- Debugging
	"mfussenegger/nvim-dap", -- debugging
	"leoluz/nvim-dap-go", -- debugging for go
	"nvim-neotest/nvim-nio", -- neotest for lua
	"rcarriga/nvim-dap-ui", -- UI for nvim-dap

	-- Telescope
	"nvim-telescope/telescope.nvim", -- Telescope plugin
	"nvim-telescope/telescope-media-files.nvim", -- Telescope extension to view media files

	-- Utility Plugins
	"HiPhish/rainbow-delimiters.nvim", -- rainbow brackets
	"JoosepAlviste/nvim-ts-context-commentstring", -- context aware comments
	"numToStr/Comment.nvim", -- comment stuff
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, -- indentation lines
	"windwp/nvim-autopairs", -- auto close brackets and quotes
	{
		"github/copilot.vim",
		config = function()
			vim.cmd([[ highlight CopilotSuggestion guifg=#555555 ctermfg=8 ]])
		end,
	}, -- github copilot
	"norcalli/nvim-colorizer.lua", -- color code highlighter
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
	}, -- code to image
	"wellle/context.vim", -- context based highlighting
	"sindrets/diffview.nvim",
})
