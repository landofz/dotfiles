return {
	{
		"nvim-treesitter/nvim-treesitter", -- tresitter configurations and abstraction layer
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects", -- syntax aware text-objects, select, move, swap, and peek support
			"nvim-treesitter/nvim-treesitter-context", -- show code context
			"JoosepAlviste/nvim-ts-context-commentstring", -- set the commentstring based on cursor location
		},
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local ts_conf = require("nvim-treesitter.configs")
			ts_conf.setup({
				-- One of "all", "maintained" (parsers with maintainers), or a list of
				-- languages
				ensure_installed = {
					"bash",
					"beancount",
					"c",
					"cpp",
					"css",
					"dockerfile",
					"elm",
					"erlang",
					"fennel",
					"fish",
					"hcl",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"gomod",
					"haskell",
					"html",
					"htmldjango",
					"javascript",
					"json",
					"just",
					"lua",
					"make",
					"markdown",
					"markdown_inline",
					"muttrc",
					"nix",
					"norg",
					"purescript",
					"python",
					"regex",
					"ruby",
					"rust",
					"scss",
					"sql",
					"ssh_config",
					"terraform",
					"tmux",
					"toml",
					"todotxt",
					"tsx",
					"typescript",
					"typst",
					"vim",
					"vimdoc",
					"vue",
					"yaml",
					"zathurarc",
				},

				-- Install languages synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = false,

				-- List of parsers to ignore installing
				ignore_install = { "markdown" },

				highlight = {
					-- `false` will disable the whole extension
					enable = true,
					-- list of languages that will be disabled
					disable = {},
					-- Setting this to true will run `:h syntax` and tree-sitter at the same
					-- time. Set this to `true` if you depend on 'syntax' being enabled (like
					-- for indentation). Using this option may slow down your editor, and you
					-- may see some duplicate highlights. Instead of true it can also be a
					-- list of languages
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				indent = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
			})

			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
}
