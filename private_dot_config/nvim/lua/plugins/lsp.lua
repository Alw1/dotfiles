-- Completion + LSP activation.
--
-- LSP servers are configured the modern way: one file per server in the
-- top-level `lsp/` directory (see `:help lsp-config`), enabled here with
-- `vim.lsp.enable()`. Server *binaries* are expected on $PATH — provided by
-- Nix (flake / home-manager), not installed by Mason.
local pack = require("plugins.util")

pack.add({
	pack.gh("hrsh7th/nvim-cmp"),
	pack.gh("hrsh7th/cmp-buffer"),
	pack.gh("hrsh7th/cmp-nvim-lsp"),
	pack.gh("hrsh7th/cmp-path"),
	pack.gh("L3MON4D3/LuaSnip"),
	pack.gh("saadparwaiz1/cmp_luasnip"),
})

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Servers to enable; each has a matching `lsp/<name>.lua` config file.
local servers = {
	"jsonls",
	"yamlls",
	"cssls",
	"html",
	"marksman",
	"lua_ls",
	"rust_analyzer",
	"basedpyright",
	"clangd",
	"bashls",
	"verible",
	"vhdl_ls",
}

-- Advertise nvim-cmp's extra completion capabilities to every server.
-- `vim.lsp.config('*', ...)` is merged into all server configs.
vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local opts = { buffer = event.buf }
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>gd", builtin.lsp_definitions, opts)
		vim.keymap.set("n", "<leader>go", builtin.lsp_type_definitions, opts)
		vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, opts)
		vim.keymap.set("n", "<leader>gr", builtin.lsp_references, opts)
		vim.keymap.set("n", "<leader>gs", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>gS", builtin.lsp_document_symbols, opts)
		vim.keymap.set("n", "<leader>gW", builtin.lsp_workspace_symbols, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>dd", builtin.diagnostics, opts)

		vim.keymap.set("n", "<leader>td", function()
			vim.diagnostic.enable(not vim.diagnostic.is_enabled())
		end)

		if client:supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, opts)
		else
			vim.keymap.set("n", "<leader>f", function()
				require("notify")("Formatting not supported by current LSP", "error", {
					title = "LSP Warning",
					timeout = 2000,
				})
			end, opts)
		end
	end,
})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	}),
})

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
