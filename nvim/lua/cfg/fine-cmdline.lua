local status_ok, finecmdline = pcall(require, "fine-cmdline")
if not status_ok then
	return
end

finecmdline.setup({
	cmdline = {
		enable_keymaps = true,
		smart_history = true,
		prompt = "  ",
	},
	popup = {
		position = {
			row = "10%",
			col = "50%",
		},
		size = {
			width = "40%",
		},
		border = {
			style = "rounded",
			text = {
				top = " Command Line ",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
		},
	},
})
