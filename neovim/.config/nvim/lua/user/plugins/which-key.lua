return {
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			-- document key chains
			spec = {
				{ "<leader>d", group = "[D]iagnostics" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>v", group = "Neo[v]im" },
				{ "<leader>x", group = "E[x]tra" },
			},
		},
	},
}
