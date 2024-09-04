return {
	{
		"nvim-lualine/lualine.nvim", -- status/tabline
		dependencies = {
			{ "kyazdani42/nvim-web-devicons", lazy = true },
		},
		config = function()
			require("lualine").setup({
				options = {
					globalstatus = true,
					theme = "gruvbox",
				},
			})
		end,
	},
}
