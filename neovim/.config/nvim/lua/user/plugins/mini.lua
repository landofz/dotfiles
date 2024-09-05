return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup() -- enhanced a/i text objects
			require("mini.surround").setup() -- surround actions
			require("mini.jump").setup() -- extended f and t mappings
		end,
	},
}
