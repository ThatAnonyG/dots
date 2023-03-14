local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	[[     ________  ________   ________  ________       ___    ___ ]],
	[[ ___|\   __  \|\   ___  \|\   __  \|\   ___  \    |\  \  / / |]],
	[[|\__\ \  \|\  \ \  \\ \  \ \  \|\  \ \  \\ \  \   \ \  \/ / / ]],
	[[\|__|\ \   __  \ \  \\ \  \ \  \\\  \ \  \\ \  \   \ \   / /  ]],
	[[    __\ \  \ \  \ \  \\ \  \ \  \\\  \ \  \\ \  \   \/  / /   ]],
	[[   |\__\ \__\ \__\ \__\\ \__\ \_______\ \__\\ \__\__/  / /    ]],
	[[   \|__|\|__|\|__|\|__| \|__|\|_______|\|__| \|__|\___/ /     ]],
	[[                                                 \|___|/      ]],
}
dashboard.section.buttons.val = {
	dashboard.button(
		"f",
		"  Find file",
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false, hidden = true }))<CR>"
	),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.val = "ratulsaha.me"
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
