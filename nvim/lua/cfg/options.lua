vim.opt.backup = false -- do not create backup files
vim.opt.clipboard = "unnamedplus" -- allow 2 way usage of clipboard between vim and other apps
vim.opt.cmdheight = 2 -- command line height
vim.opt.completeopt = { "menuone", "noselect" } -- auto complete popup enabled and disable initial item selection
vim.opt.fileencoding = "utf-8" -- use UTF-8 file encoding
vim.opt.hlsearch = true -- highlight all search items
vim.opt.ignorecase = true -- ignore casing in search exp
vim.opt.mouse = "a" -- enable mouse in all modes
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- don't show the mode in status bar
vim.opt.showtabline = 2 -- show the file tabs even if only one file is open
vim.opt.smartcase = true -- enable smart case searches
vim.opt.smartindent = true -- smart indentation
vim.opt.splitbelow = true -- split below for horizontal splitting
vim.opt.splitright = true -- split to right for vertical splitting
vim.opt.swapfile = false -- don't create swapfiles
vim.opt.undofile = true -- enable undo
vim.opt.updatetime = 300 -- faster completetion
vim.opt.writebackup = false -- don't allow parallel editing of files in multiple programs
vim.opt.expandtab = true -- use spaces for tabs
vim.opt.shiftwidth = 2 -- spaces used for indentation
vim.opt.tabstop = 2 -- length of tabs
vim.opt.number = true -- line numbering
vim.opt.cursorline = true -- line highlight
vim.opt.numberwidth = 4 -- line number column width
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.wrap = false -- don't wrap lines
vim.opt.scrolloff = 8 -- add 8 lines below cursor
vim.opt.sidescrolloff = 8 -- add some space after the cursor
vim.opt.iskeyword = "@,48-57,192-255" -- don't treat _ separated words as a single word when using d-w or d-b
vim.opt.termguicolors = true -- enable wider range of colors
vim.opt.shortmess:append "c" -- Short messages option
vim.opt.whichwrap:append "h,l,<,>,[,]" -- cursor behavior

