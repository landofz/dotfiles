local ts_status_ok, ts_conf = pcall(require, "nvim-treesitter.configs")
if not ts_status_ok then
	return
end

ts_conf.setup({
	-- One of "all", "maintained" (parsers with maintainers), or a list of
	-- languages
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"dockerfile",
		"elm",
		"erlang",
		"hcl",
		"go",
		"gomod",
		"help",
		"html",
		"htmldjango",
		"javascript",
		"json",
		"lua",
		"make",
		"nix",
		"python",
		"ruby",
		"rust",
		"scss",
		"sql",
		"terraform",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},

	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,

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
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
