local pack = require("plugins.util")

pack.add({ pack.gh("nvimdev/dashboard-nvim") })

local telescope = require("telescope.builtin")

local pikachu_logo = [[
              ▀████▀▄▄              ▄█
                █▀    ▀▀▄▄▄▄▄   ▄▄▄▀▀█
        ▄        █          ▀▀▀▀   ▄▀
       ▄▀▀▀▄      ▀▄              ▀▄▀
      ▄▀    █     █▀   ▄█▀▄      ▄█
      ▀▄     ▀▄  █     ▀██▀     ██▄█
       ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █
        █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀
       █   █  █                   ▄▀
]]

local logo = string.rep("\n", 8) .. pikachu_logo .. "\n\n"

require("dashboard").setup({
	theme = "doom",
	hide = {
		statusline = false, -- Don't enable, messes up lualine
	},
	config = {
		header = vim.split(logo, "\n"),

		center = {
			{ action = function() telescope.find_files() end, desc = " Find File", icon = "󰍉 ", key = "f" },
			{ action = function() telescope.live_grep() end, desc = " Find Text", icon = "󱎸 ", key = "g" },
			{ action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
			{ action = function() vim.pack.update() end, desc = " Update Plugins", icon = "󰒲 ", key = "u" },
			{ action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit", icon = " ", key = "q" },
		},
		footer = function()
			local n = #vim.pack.get()
			return { "⚡ " .. n .. " plugins managed by vim.pack" }
		end,
	},
})
