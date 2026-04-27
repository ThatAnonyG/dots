local status_ok, snacks = pcall(require, "snacks")
if not status_ok then
	return
end

snacks.setup({
	notifier = {
		enabled = true,
		timeout = 3000,
		top_down = false,
		style = "compact",
	},
})

vim.notify = snacks.notifier.notify
