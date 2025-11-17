return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',  -- Optional: for debugging
  },
  ft = { "scala", "sbt", "java" },
  config = function()
    local metals_config = require("metals").bare_config()
    
    -- Metals will be available from nix shell
    metals_config.settings = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl",
      },
    }
    
    -- Capabilities (if using nvim-cmp)
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
    
    -- On attach
    metals_config.on_attach = function(client, bufnr)
      local opts = { noremap=true, silent=true, buffer=bufnr }
      
      -- Standard LSP mappings
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      
      -- Metals specific
      vim.keymap.set('n', '<leader>mc', require('metals').commands, opts)
      vim.keymap.set('n', '<leader>mi', require('metals').toggle_setting('showImplicitArguments'), opts)
      
      -- Worksheet evaluation
      vim.keymap.set('n', '<leader>ws', function()
        require('metals').worksheet_hover()
      end, opts)
    end
    
    -- Autocmd to start metals
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "java" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
