-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---- Move highlighted lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

---- Cursor stays in place when appending following line to current line
vim.keymap.set("n", "J", "mzJ`z")

---- Cursor stays in the middle of the screen when jumping half page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

---- Search terms stay in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

---- Send to void register
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

---- Send highlited term to void register then paste
vim.keymap.set("x", "<leader>p", '"_dP')

---- Copy to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

---- Capital Q in the ninth circle of hell, don't go there
vim.keymap.set("n", "Q", "<nop>")

---- Builds a substitution string around the highlighted term
vim.keymap.set("n", "<leader>sss", [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>]])

---- Make executable
vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })

-- Quickfix
vim.keymap.set("n", "<C-j>", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":cprev<CR>", { silent = true })
