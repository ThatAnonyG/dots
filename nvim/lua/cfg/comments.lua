local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup({
	pre_hook = function(ctx)
		local comment_utils = require("Comment.utils")
		local tscomment_utils = require("ts_context_commentstring.utils")

		local location = nil
		if ctx.type == comment_utils.ctype.blockwise then
			location = tscomment_utils.get_cursor_location()
		elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
			location = tscomment_utils.get_visual_start_location()
		end

		if location ~= nil then
			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = ctx.type == comment_utils.ctype.linewise and "__default" or "__multiline",
				location = location,
			})
		end
	end,
})
