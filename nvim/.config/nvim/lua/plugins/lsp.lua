return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local servers = {
			"jsonls",
			"yamlls",
			"cssls",
			"html",
			"marksman",
			"lua_ls",
			"rust_analyzer",
			"pyright",
			"clangd",
			"bashls",
			"verible",
			"vhdl_ls",
		}

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		vim.lsp.enable(servers)

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
				vim.keymap.set('n', '<leader>go', vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<leader>gs', vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				-- Toggle Diagnostics
				vim.keymap.set('n', '<leader>td', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end)

				if client.supports_method("textDocument/formatting") then
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				else
					vim.keymap.set("n", "<leader>f", function()
						require("notify")("Formatting not supported by current LSP", "error", {
							title = "LSP Warning",
							timeout = 2000
						})
						return ""
					end, opts)
				end
			end,
		})

		-- Trigger hover documentation after updatetime
		-- vim.opt.updatetime = 2000
		-- vim.api.nvim_create_autocmd("CursorHold", {
		-- 	pattern = "*",
		-- 	callback = function()
		-- 		vim.lsp.buf.hover()
		-- 	end,
		-- })

		-- Autocompletion Setup
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
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			virtual_text = true,
			-- virtual_lines = true, -- multiline diagnostics
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true
		})
	end,
}
