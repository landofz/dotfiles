return {
	{
		"hrsh7th/nvim-cmp", -- autocompletion plugin
		event = "InsertEnter",
		dependencies = {
			"onsails/lspkind.nvim", -- shows pictograms describing completion item category
			"hrsh7th/cmp-buffer", -- buffer completions
			"hrsh7th/cmp-path", -- path completions
			"hrsh7th/cmp-cmdline", -- cmdline completions
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-nvim-lua", -- neovim Lua API
			"hrsh7th/cmp-nvim-lsp-signature-help", -- displaying function signatures with the current parameter emphasized
			"saadparwaiz1/cmp_luasnip", -- snippets source for nvim-cmp
			"L3MON4D3/LuaSnip", -- snippets plugin
			"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		},
		config = function()
			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			local source_mapping = {
				lazydev = "[Lazydev]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Nvim_Lua]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			}
			local lspkind = require("lspkind")
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				-- completion = {
				--   autocomplete = false
				-- },
				performance = {
					debounce = 500,
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }), -- accept the completion
					["<C-Space>"] = cmp.mapping.complete(), -- manually trigger a completion
					["<C-e>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					-- move to the right/left of each of the expansion locations
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item.kind = lspkind.presets.default[vim_item.kind]
						vim_item.menu = source_mapping[entry.source.name]
						return vim_item
					end,
				},
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions
						group_index = 0,
					},
					{ name = "nvim_lua", keyword_length = 2 },
					{ name = "nvim_lsp", keyword_length = 3 },
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "path" },
					{
						name = "buffer",
						keyword_length = 5,
						option = {
							get_bufnrs = function()
								-- get words from all buffers
								return vim.api.nvim_list_bufs()
							end,
						},
					},
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
			})
		end,
	},
}
