vim.keymap.set("n", "<leader>pg", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>s", ":vsplit<CR>")

local toggleTerm = function()
	vim.cmd(":ToggleTerm")
end

vim.keymap.set({ "n", "t" }, "<C-t>", toggleTerm)

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

vim.keymap.set('v', 'y', '"*y')
vim.keymap.set('v', 'p', '"*p')
