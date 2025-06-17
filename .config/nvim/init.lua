require("core")

-- Set theme to the theme of the last session
local theme = require('last-color').recall() or 'default'
vim.cmd.colorscheme(theme)
