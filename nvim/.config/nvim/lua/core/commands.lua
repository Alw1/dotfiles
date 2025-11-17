vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.csv",
  callback = function()
    require("csvview").enable()
  end,
})

-- vim.api.nvim_create_autocmd({"BufLeave"}, {
--   pattern = "*.csv",
--   callback = function()
--     require("csvview").disable()
--   end,
-- })

