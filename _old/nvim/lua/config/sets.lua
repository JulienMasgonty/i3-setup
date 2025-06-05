-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.smartindent = true

-- backups & undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- folds
vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
--vim.g.markdown_folding = 1 -- enable markdown markdown_fold


-- misc
vim.opt.cursorline = true -- highlights cursor line
vim.opt.wrap = false -- do not wrap the line after the max line length
vim.opt.termguicolors = true -- nice colors
vim.opt.scrolloff = 8 -- keep 8 lines at the bottom
vim.opt.signcolumn = "yes" -- enable sign column
vim.opt.isfname:append("@-@") -- to handle files with @ in them
vim.opt.updatetime = 50 -- sets the update time to 50ms
vim.opt.colorcolumn = "80" -- color the column 80 as an indication of reasonable line lengh
