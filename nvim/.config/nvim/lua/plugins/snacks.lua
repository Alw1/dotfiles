local pack = require("plugins.util")

pack.add({ pack.gh("folke/snacks.nvim") })

---@type snacks.Config
require("snacks").setup({
	bigfile = { enabled = true },
	animate = { enabled = true },
	dashboard = { enabled = false },
	explorer = { enabled = false },
	indent = { enabled = true },
	input = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})
