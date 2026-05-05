return {

	-- Matugen wallpaper-adaptive colorscheme
	{
		"daedlock/matugen.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("matugen").setup({
				colors_path = "~/.config/matugen/colors.json",
			})
			vim.cmd.colorscheme("matugen")
		end,
	},

	-- Themes
	"rebelot/kanagawa.nvim",
	"sho-87/kanagawa-paper.nvim",
	"neanias/everforest-nvim",
	"projekt0n/github-nvim-theme",
	"EdenEast/nightfox.nvim",
	"comfysage/evergarden",
	"rose-pine/neovim",
	"catppuccin/nvim",
	'everviolet/nvim',
	-- "daschw/leaf", -- Broken?

	-- Plugin to remember last picked theme 
	"raddari/last-color.nvim",

	version = false,
	lazy = false,
	priority = 1000,
}
