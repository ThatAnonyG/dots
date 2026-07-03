return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				ST1003 = false,
				ST1000 = false,
			},
			staticcheck = true,
		},
	},
}
