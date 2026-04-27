local status_ok, mini_comment = pcall(require, "mini.comment")
if not status_ok then
	return
end

mini_comment.setup({
	mappings = {
		comment = "<C-_>",
		comment_line = "<C-_>",
		comment_visual = "<C-_>",
		textobject = "<C-_>",
	},
})

local status_ok, mini_pairs = pcall(require, "mini.pairs")
if not status_ok then
	return
end

mini_pairs.setup({})

local status_ok, mini_surround = pcall(require, "mini.surround")
if not status_ok then
	return
end

mini_surround.setup({})
