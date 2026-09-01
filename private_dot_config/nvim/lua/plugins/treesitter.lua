local pack = require("plugins.util")

-- Rebuild parsers after the plugin is installed or updated (replaces lazy's
-- `build = ":TSUpdate"`). Registered before `add()` so it catches first install.
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

-- Pinned to `master`: the config below uses the classic `nvim-treesitter.configs`
-- API, which does not exist on the rewritten `main` branch (the new default).
pack.add({
	{ src = pack.gh("nvim-treesitter/nvim-treesitter"), version = "master" },
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c", "cpp", "lua", "rust", "python", "haskell", "vhdl",
		"bash", "json", "yaml", "toml", "markdown", "markdown_inline",
		"html", "css", "javascript", "typescript", "tsx",
		"vim", "vimdoc", "query", "regex", "diff", "gitcommit",
	},
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = true },
})
