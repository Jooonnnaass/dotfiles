return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>g", ":Git<CR>")
			vim.keymap.set("n", "<leader>gp", ":Git push<CR>")
			vim.keymap.set("n", "<leader>gc", ":Git commit<CR>")
			vim.keymap.set("n", "<leader>gf", ":Git fetch<CR>")
			vim.keymap.set("n", "<leader>gpu", ":Git pull<CR>")
			vim.keymap.set("n", "<leader>gs", ":Git status<CR>")
			vim.keymap.set("n", "<leader>ga", ":Git add -u<CR>")
		end
	},
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
	}
}
