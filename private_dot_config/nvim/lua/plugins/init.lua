-- Plugins are managed with the native `vim.pack` manager (Neovim 0.12+).
-- Each module below both *installs* its plugin(s) (via `vim.pack.add`) and
-- *configures* them, so everything about a plugin lives in one file. They are
-- required here in load order (colorschemes and core UI first).
--
-- Handy commands:
--   :lua vim.pack.update()            update all plugins (review, then :write)
--   :lua vim.pack.update({ 'name' })  update a single plugin
--   :lua =vim.pack.get()              list managed plugins
require("plugins.themes")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.snacks")
require("plugins.lualine")
require("plugins.which-key")
require("plugins.dashboard")
require("plugins.color_picker")
require("plugins.little_plugins")
require("plugins.conform")
require("plugins.tabline")
require("plugins.ssh")
