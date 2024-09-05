return {
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				indent = {
					char = "┊", -- an alternative is "▏"
				},
			})
		end,
	}, -- show indentation guides
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				-- pre_hook = function(ctx)
				--   -- Only calculate commentstring for tsx filetypes
				--   if vim.bo.filetype == 'typescriptreact' then
				--     local U = require('Comment.utils')
				--
				--     -- Detemine whether to use linewise or blockwise commentstring
				--     local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
				--
				--     -- Determine the location where to calculate commentstring from
				--     local location = nil
				--     if ctx.ctype == U.ctype.block then
				--       location = require('ts_context_commentstring.utils').get_cursor_location()
				--     elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
				--       location = require('ts_context_commentstring.utils').get_visual_start_location()
				--     end
				--
				--     return require('ts_context_commentstring.internal').calculate_commentstring({
				--       key = type,
				--       location = location,
				--     })
				--   end
				-- end,
			})
		end,
	}, -- commenting support
	{
		"lewis6991/gitsigns.nvim", -- git info in the signs column
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
				},
				on_attach = function(bufnr)
					vim.api.nvim_buf_set_keymap(bufnr, "n", "]c", [[<cmd>lua require('gitsigns').next_hunk()<CR>]], {})
					vim.api.nvim_buf_set_keymap(bufnr, "n", "[c", [[<cmd>lua require('gitsigns').prev_hunk()<CR>]], {})
					vim.api.nvim_buf_set_keymap(
						bufnr,
						"n",
						"<leader>gs",
						[[<cmd>lua require('gitsigns').stage_hunk()<CR>]],
						{}
					)
				end,
			})
		end,
	},
	"mbbill/undotree", -- undo history visualizer
	"tpope/vim-fugitive", -- git wrapper
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	}, -- make on-screen navigation quicker and more natural
	{
		"anuvyklack/hydra.nvim",
		config = function()
			local hydra = require("hydra")
			local cmd = require("hydra.keymap-util").cmd
			hydra({
				name = "Telescope",
				config = {
					color = "teal",
					invoke_on_body = true,
					hint = {
						position = "middle",
						border = "rounded",
					},
				},
				mode = "n",
				body = "<Leader>f",
				heads = {
					{ "f", cmd("Telescope find_files") },
					{ "g", cmd("Telescope live_grep") },
					{ "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
					{ "h", cmd("Telescope help_tags"), { desc = "vim help" } },
					{ "m", cmd("Telescope marks"), { desc = "marks" } },
					{ "k", cmd("Telescope keymaps") },
					{ "O", cmd("Telescope vim_options") },
					{ "r", cmd("Telescope resume") },
					{ "p", cmd("Telescope projects"), { desc = "projects" } },
					{ "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
					{ "?", cmd("Telescope search_history"), { desc = "search history" } },
					{ ";", cmd("Telescope command_history"), { desc = "command-line history" } },
					{ "c", cmd("Telescope commands"), { desc = "execute command" } },
					{ "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
					{ "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
					{ "<Esc>", nil, { exit = true, nowait = true } },
				},
			})
		end,
	}, -- custom submodes and menus
	{ "windwp/nvim-autopairs", opts = {} }, -- autoclose parens and similar constructs
}
