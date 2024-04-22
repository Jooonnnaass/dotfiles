vim.g.mapleader = " "
-- open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move seleted line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- format file
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- toggle terminal
vim.keymap.set("n", "t", "<CMD>ToggleTerm<CR>")

vim.keymap.set("t", "<esc>", "<CMD>ToggleTerm<CR>")

-- vsplit current buffer
vim.keymap.set("n", "<leader>s", "<CMD>:vsplit<CR>")

-- got to vsplit right
vim.keymap.set("n", "<leader>l", "<C-w>l")
-- got to vsplit left
vim.keymap.set("n", "<leader>h", "<C-w>h")
