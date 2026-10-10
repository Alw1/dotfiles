local pack = require("plugins.util")

pack.add({
	pack.gh("romgrk/barbar.nvim"),
	pack.gh("lewis6991/gitsigns.nvim"), -- optional: git status in the tabline
	pack.gh("nvim-tree/nvim-web-devicons"), -- optional: file icons
})

-- barbar wants this set before its setup runs.
vim.g.barbar_auto_setup = false

require("barbar").setup({
	animation = true,
})
