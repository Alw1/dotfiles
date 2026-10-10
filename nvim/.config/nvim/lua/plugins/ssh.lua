local pack = require("plugins.util")

pack.add({
	pack.gh("nosduco/remote-sshfs.nvim"),
	pack.gh("nvim-telescope/telescope.nvim"),
	pack.gh("nvim-lua/plenary.nvim"),
})

require("remote-sshfs").setup({
	-- Refer to remote-sshfs' documentation, or leave empty for defaults.
})
