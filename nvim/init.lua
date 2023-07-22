-- map leader key before lazy.nvim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", 
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- setup lazy.nvim with plugins module
-- don't add your plugins here, add them in the lua/plugins dir instead
require("lazy").setup({
	spec = {
    { import = "plugins.ui" },
		{ import = "plugins.core" },
		{ import = "plugins.extras" },
	},
})


require("config.autocmds") 
require("config.keymaps") 
require("config.options") 
