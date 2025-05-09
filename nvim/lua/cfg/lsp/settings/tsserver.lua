return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	init_options = { hostInfo = "neovim", maxTsServerMemory = 4096, preferences = { disableSuggestions = true } },
	root_dir = require("lspconfig").util.root_pattern("package.json"),
	single_file_support = true,
}
