require("nvim-treesitter").install({ "all" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

require("nvim-ts-autotag").setup()
