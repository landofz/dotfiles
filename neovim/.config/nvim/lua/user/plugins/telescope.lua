return {
	{
		"nvim-telescope/telescope.nvim", -- generic picker
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			}, -- native FZF sorter for telescope
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
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "search [b]uffers" })
			vim.keymap.set("n", "<leader>p", function()
				builtin.find_files({ hidden = true, follow = true })
			end, { desc = "search by [p]ath" })
			vim.keymap.set("n", "<leader>sg", function()
				local cd = vim.fn.getcwd()
				if vim.fs.normalize("~/.config/nvim") == cd then
					builtin.live_grep({ additional_args = { "--follow" } })
				else
					builtin.live_grep()
				end
			end, { desc = "[s]earch by [g]repping" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
			vim.keymap.set("n", "<leader>st", builtin.treesitter, { desc = "[s]earch [t]reesitter" })
			vim.keymap.set("n", "<leader>sm", builtin.keymaps, { desc = "[s]earch [m]appings" })
			vim.keymap.set("n", "<leader>ss", builtin.git_files, { desc = "[s]earch git file[s]" })
			vim.keymap.set("n", "<leader>sy", builtin.lsp_document_symbols, { desc = "[s]earch document s[y]mbols" })
			vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[s]earch [c]ommands" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch [w]ord under cursor" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
			vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "[s]earch [o]ld files" })
			vim.keymap.set("n", "<leader>sb", builtin.builtin, { desc = "[s]earch telescope [b]uiltins" })
		end,
	},
}
