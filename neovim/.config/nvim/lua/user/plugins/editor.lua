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
			---@diagnostic disable-next-line: missing-fields
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
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							---@diagnostic disable-next-line: param-type-mismatch
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Go to next hunk" })
					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							---@diagnostic disable-next-line: param-type-mismatch
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Go to previous hunk" })

					-- Actions
					map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>gs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage hunk" })
					map("v", "<leader>gr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset hunk" })
					map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
					map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>gb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Blame line" })
					map("n", "<leader>gB", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
					map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff against index" })
					map("n", "<leader>gD", function()
						---@diagnostic disable-next-line: param-type-mismatch
						gitsigns.diffthis("~")
					end, { desc = "Diff against the last commit" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	"mbbill/undotree", -- undo history visualizer
	"tpope/vim-fugitive", -- git wrapper
	{
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "<leader>e", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "<leader>E", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
		end,
	}, -- make on-screen navigation quicker and more natural, an alternative is https://github.com/folke/flash.nvim
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
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			-- automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	}, -- autoclose parens and similar constructs
	{
		"famiu/bufdelete.nvim",
		config = function()
			vim.keymap.set("n", "<leader>bd", require("bufdelete").bufdelete, { desc = "[b]uffer [d]elete" })
		end,
	},
	{ -- a general purpose UI library with greeter functionality
		"goolord/alpha-nvim",
		-- config = function()
		-- 	require("alpha").setup(require("alpha.themes.dashboard").config)
		-- end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			vim.keymap.set("n", "<leader>xc", function()
				local col = require("colorizer")
				local opts = { mode = "background", css = true }
				if col.is_buffer_attached(0) then
					col.detach_from_buffer(0)
				else
					col.attach_to_buffer(0, opts)
				end
			end, { desc = "toggle colorizer" })
		end,
	},
}
