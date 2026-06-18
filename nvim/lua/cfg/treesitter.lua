vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime")

require("nvim-treesitter").install({ "all" })

vim.api.nvim_create_autocmd("FileType", {
	desc = "Start treesitter",
	callback = function(args)
		local exclude = {
			"TelescopePrompt",
			"TelescopeResults",
			"blink-cmp-menu",
			"blink-cmp-documentation",
			"NvimTree",
			"lazy",
			"mason",
			"notify",
		}
		local ft = vim.bo[args.buf].filetype
		if vim.tbl_contains(exclude, ft) then
			return
		end
		pcall(vim.treesitter.start, args.buf)
	end,
})

require("nvim-ts-autotag").setup()
