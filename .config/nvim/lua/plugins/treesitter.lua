return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "cpp", "lua", "rust", "python", "haskell", "vhdl"},
          sync_install = false,
		  auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
 }
