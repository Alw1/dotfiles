require("core")

-- Set theme to the theme of the last session
local ok, last_color = pcall(require, 'last-color')
local theme = ok and last_color.recall() or 'habamax'
pcall(vim.cmd.colorscheme, theme)
