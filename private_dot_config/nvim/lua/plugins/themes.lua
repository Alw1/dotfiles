local pack = require("plugins.util")

-- Colorschemes and theme memory. Most themes need no setup and are ready to
-- `:colorscheme`. The final colorscheme for the session is chosen by `init.lua`
-- (via last-color), so we don't set one here.
pack.add({
	pack.gh("daedlock/matugen.nvim"),
	pack.gh("rebelot/kanagawa.nvim"),
	pack.gh("sho-87/kanagawa-paper.nvim"),
	pack.gh("neanias/everforest-nvim"),
	pack.gh("projekt0n/github-nvim-theme"),
	pack.gh("EdenEast/nightfox.nvim"),
	pack.gh("comfysage/evergarden"),
	-- These two repos have generic names ("neovim"/"nvim"), so name them
	-- explicitly to avoid collisions in the pack directory.
	{ src = pack.gh("rose-pine/neovim"), name = "rose-pine" },
	{ src = pack.gh("everviolet/nvim"), name = "everviolet" },
	pack.gh("raddari/last-color.nvim"),
})

-- Matugen needs configuring so that the `matugen` colorscheme exists.
require("matugen").setup({
	colors_path = "~/.config/matugen/colors.json",
})
