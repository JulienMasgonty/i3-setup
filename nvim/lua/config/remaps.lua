vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Opens netrw 
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move highlighted lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Cursor stays in place when appending following line to the current line
vim.keymap.set("n", "J", "mzJ`z")

-- Jump half page but cursor stays in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Search terms stay in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- sends it to void register (basically removes it without copying it
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Makes it so copied search over highlighted words stay in the clipboard
-- by sending the highlighted words to the void register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- capital Q is the ninth circle of hell, we don't want to go there
vim.keymap.set("n", "Q", "<nop>")

-- calls lsp format 
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- builds a substition string around the highlighted words
vim.keymap.set("n", "<leader>s", [[:%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left>]])

-- makes executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
