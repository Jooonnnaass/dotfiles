return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require('nvim-treesitter.configs').setup({
			ensure_installed = {
				"rust", "c", "lua", "javascript", "typescript", "markdown", "java", "python"
			},
			sync_install = false,
			auto_install = true,
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
			},
		})
	end,
}
