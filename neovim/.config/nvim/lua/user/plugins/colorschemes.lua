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
			vim.o.termguicolors = true
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{ "savq/melange-nvim" }, -- control flow uses warm colors and data uses cold colors
	"folke/tokyonight.nvim", -- support for lsp, treesitter and a lot of plugins, has color definitions for terminals, tmux and the like
	{ "catppuccin/nvim", name = "catppuccin" }, -- has integrations with many plugins
	{ "p00f/alabaster.nvim" }, -- minimal amount of highlighting
	{ "kepano/flexoki" }, -- inspired by analog printing inks and warm shades of paper
}
