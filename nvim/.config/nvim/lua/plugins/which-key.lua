local pack = require("plugins.util")

pack.add({ pack.gh("folke/which-key.nvim") })

require("which-key").setup({
	delay = 300,
	icons = {
		mappings = false,
	},
	spec = {
		{ "<leader>g", group = "goto" },
		{ "<leader>p", group = "picker" },
		{ "<leader>t", group = "toggle" },
		{ "<leader>y", group = "yank" },
	},
})
