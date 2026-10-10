-- A grab bag of smaller plugins.
--
-- `romainl/vim-cool`, `rcarriga/nvim-notify` and `mrcjkb/haskell-tools.nvim`
-- need no explicit setup: vim-cool works on load, notify configures itself on
-- first use, and haskell-tools sets itself up through its ftplugin for Haskell
-- filetypes.
local pack = require("plugins.util")

pack.add({
	pack.gh("romainl/vim-cool"),
	pack.gh("rcarriga/nvim-notify"),
	{ src = pack.gh("mrcjkb/haskell-tools.nvim"), version = vim.version.range("6") },
	pack.gh("hat0uma/csvview.nvim"),
	pack.gh("stevearc/oil.nvim"),
	pack.gh("lewis6991/gitsigns.nvim"),
	pack.gh("windwp/nvim-autopairs"),
	pack.gh("folke/trouble.nvim"),
	pack.gh("nvim-tree/nvim-web-devicons"), -- used by oil and trouble
})

-- CSV viewer (also toggled per-file from lua/core/commands.lua).
require("csvview").setup({
	parser = { comments = { "#", "//" } },
	keymaps = {
		textobject_field_inner = { "if", mode = { "o", "x" } },
		textobject_field_outer = { "af", mode = { "o", "x" } },
		jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
		jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
		jump_next_row = { "<Enter>", mode = { "n", "v" } },
		jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
	},
})

-- File explorer as a buffer.
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Git gutter signs + hunk keymaps.
require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local opts = { buffer = bufnr }

		vim.keymap.set("n", "]h", gs.next_hunk, opts)
		vim.keymap.set("n", "[h", gs.prev_hunk, opts)
		vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
		vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
		vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
		vim.keymap.set("n", "<leader>hb", gs.blame_line, opts)
	end,
})

require("nvim-autopairs").setup({})

-- Diagnostics / quickfix list UI.
require("trouble").setup({})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
