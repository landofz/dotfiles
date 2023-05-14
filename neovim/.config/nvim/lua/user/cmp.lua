local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[Nvim_Lua]",
	luasnip = "[Snippet]",
	buffer = "[Buffer]",
	path = "[Path]",
}
local lspkind = require("lspkind")

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
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm(),
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
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			vim_item.menu = source_mapping[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "nvim_lua", keyword_length = 2 },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip", keyword_length = 2 },
		{
			name = "buffer",
			keyword_length = 2,
			option = {
				get_bufnrs = function()
					-- get words from all buffers
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
})
