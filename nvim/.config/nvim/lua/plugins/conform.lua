local pack = require("plugins.util")

pack.add({ pack.gh("stevearc/conform.nvim") })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format", "ruff_fix" },
		rust = { "rustfmt" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		yaml = { "prettierd", "prettier", stop_after_first = true },
		markdown = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		sh = { "shfmt" },
		bash = { "shfmt" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
})

vim.keymap.set("", "<leader>F", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer (conform)" })
