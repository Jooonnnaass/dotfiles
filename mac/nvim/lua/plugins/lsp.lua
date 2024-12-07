return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Reserve a space in the gutter
		vim.opt.signcolumn = 'yes'

		-- Activate gitsigns
		vim.diagnostic.config({
			signs = true,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = '✘',
					[vim.diagnostic.severity.WARN] = '▲',
					[vim.diagnostic.severity.HINT] = '⚑',
					[vim.diagnostic.severity.INFO] = '»',
				},
			},
		})

		-- Add cmp_nvim_lsp capabilities settings to lspconfig
		-- This should be executed before you configure any language server
		local lspconfig_defaults = require('lspconfig').util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			'force',
			lspconfig_defaults.capabilities,
			require('cmp_nvim_lsp').default_capabilities()
		)
		-- Format on save
		local buffer_autoformat = function(bufnr)
			local group = 'lsp_autoformat'
			vim.api.nvim_create_augroup(group, { clear = false })
			vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = bufnr,
				group = group,
				desc = 'LSP format on save',
				callback = function()
					-- note: do not enable async formatting
					vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
				end,
			})
		end

		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
				vim.keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')

				local id = vim.tbl_get(event, 'data', 'client_id')
				local client = id and vim.lsp.get_client_by_id(id)
				if client == nil then
					return
				end

				-- make sure there is at least one client with formatting capabilities
				if client.supports_method('textDocument/formatting') then
					buffer_autoformat(event.buf)
				end
			end,
		})

		require('mason').setup({})
		require('mason-lspconfig').setup({
			-- Always installed lsps
			ensure_installed = { 'lua_ls', 'rust_analyzer', 'ts_ls', 'pyright', 'clangd' },
			handlers = {
				function(server_name)
					require('lspconfig')[server_name].setup({})
				end,

				lua_ls = function()
					require('lspconfig').lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = { 'vim' },
								},
							},
						},
					})
				end,
			}
		})
		local cmp = require('cmp')

		require('luasnip.loaders.from_vscode').lazy_load()

		cmp.setup({
			preselect = 'item',
			completion = {
				completeopt = 'menu,menuone,noinsert'
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'buffer' },
				{ name = 'luasnip' },
			},
			snippet = {
				expand = function(args)
					-- You need Neovim v0.10 to use vim.snippet
					-- vim.snippet.expand(args.body)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- Enter to select
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				-- Super tab
				['<Tab>'] = cmp.mapping(function(fallback)
					local luasnip = require('luasnip')
					local col = vim.fn.col('.') - 1

					if cmp.visible() then
						cmp.select_next_item({ behavior = 'select' })
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
						fallback()
					else
						cmp.complete()
					end
				end, { 'i', 's' }),

				-- Super shift tab
				['<S-Tab>'] = cmp.mapping(function(fallback)
					local luasnip = require('luasnip')

					if cmp.visible() then
						cmp.select_prev_item({ behavior = 'select' })
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			}),
		})
	end,
}
