-- GLOBAL

vim.g.mapleader = " "
vim.g.maplocalleader = " "

---- Opens netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

---- Move highlighted lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

---- Cursor stays in place when appending following line to the current line
vim.keymap.set("n", "J", "mzJ`z")

---- Jump half page but cursor stays in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

---- Search terms stay in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

---- send to void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

---- paste and send highlighted word to void register
vim.keymap.set("x", "<leader>p", "\"_dP")

---- copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

---- capital Q is the ninth circle of hell
vim.keymap.set("n", "Q", "<nop>")

---- builds a substitution string around the highlited term
vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>]])

---- make executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })



-- LSP

---- calls lsp format
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

---- go to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})

---- code actions
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

---- display message in popup window
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap=true, silent=true })
