vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.cmd([[ highlight CopilotSuggestion guifg=#555555 ctermfg=8 ]])
