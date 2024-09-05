return {
	{
		"ellisonleao/gruvbox.nvim", -- has tresitter support, customizable
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				overrides = {
					MiniJump = { bg = require("gruvbox").palette.bright_red },
				},
			})
			vim.o.background = "dark"
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	"folke/tokyonight.nvim", -- support for lsp, treesitter and a lot of plugins, has color definitions for terminals, tmux and the like
	{ "catppuccin/nvim", name = "catppuccin" }, -- has integrations with many plugins
}
