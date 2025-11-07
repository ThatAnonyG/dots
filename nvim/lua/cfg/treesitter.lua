local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = "all",
	sync_install = false,
	ignore_install = { "ipkg" },
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = true,
		indent = { enable = true, disable = { "yaml" } },
	},
	autopairs = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	auto_install = true,
	modules = {},
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
