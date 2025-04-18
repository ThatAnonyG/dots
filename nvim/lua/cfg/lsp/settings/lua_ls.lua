return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "jit" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
					[vim.fn.stdpath("data") .. "/lazy"] = true,
					["${3rd}/luv/library"] = true,
				},
			},
		},
	},
}
