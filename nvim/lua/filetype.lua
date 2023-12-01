vim.g.do_filetype_lua = 1

vim.filetype.add({
	pattern = {
		[".*"] = {
			priority = -math.huge,
			function(_, bufnr)
				local content = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
				if vim.regex([[^#!.*(sh|bash)$]]):match_str(content) ~= nil then
					return "sh"
        elseif vim.regex([[^#!.*(python).*$]]):match_str(content) ~= nil then
          return "py"
				end
			end,
		},
	},
})
