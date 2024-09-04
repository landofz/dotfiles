return {
	{
		"nvim-telescope/telescope.nvim", -- generic picker
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- native FZF sorter for telescope
			-- "nvim-telescope/telescope-smart-history.nvim", -- memorizes prompt input for a specific context
			-- "kkharji/sqlite.lua", -- dependency for smart history
			"nvim-telescope/telescope-ui-select.nvim", -- sets vim.ui.select to telescope
		},
		config = function()
			local actions = require("telescope.actions")
			local data = assert(vim.fn.stdpath("data")) --[[@as string]]
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,

							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,

							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,

							["<C-_>"] = actions.which_key,
						},
					},
					file_ignore_patterns = { "^[.]git/" },
					path_display = { "truncate" },
				},
				extensions = {
					wrap_results = true,
					fzf = {},
					history = {
						path = vim.fs.joinpath(data, "telescope-history.sqlite3"),
						limit = 100,
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "smart_history")
			pcall(require("telescope").load_extension, "ui-select")

			local builtin = require("telescope.builtin")
			vim.api.nvim_set_keymap(
				"n",
				"<leader>b",
				[[<cmd>lua require('telescope.builtin').buffers()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>p",
				[[<cmd>lua require('telescope.builtin').find_files({hidden = true, follow = true})<CR>]],
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "<leader>sg", function()
				local cd = vim.fn.getcwd()
				if vim.fs.normalize("~/.config/nvim") == cd then
					builtin.live_grep({ additional_args = { "--follow" } })
				else
					builtin.live_grep()
				end
			end, { desc = "[s]earch by [g]repping" })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>sh",
				[[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>st",
				[[<cmd>lua require('telescope.builtin').treesitter()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.keymap.set("n", "<leader>sm", builtin.keymaps, { desc = "[s]earch [m]appings" })
			vim.keymap.set("n", "<leader>ss", builtin.git_files, { desc = "[s]earch git file[s]" })
			vim.keymap.set("n", "<leader>sy", builtin.lsp_document_symbols, { desc = "[s]earch document s[y]mbols" })
			vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[s]earch [c]ommands" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch [w]ord under cursor" })
		end,
	},
}
