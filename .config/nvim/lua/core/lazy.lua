local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
	print('Installation complete')
end
vim.opt.rtp:prepend(lazypath)

-- Looks in plugin directory for plugins
require("lazy").setup("plugins", {})
