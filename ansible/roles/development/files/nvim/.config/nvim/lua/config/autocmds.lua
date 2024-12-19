-- autocmd FileType apache setlocal commentstring=#\ %s
-- commentstrings
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("NixCommentString", { clear = true }),
	callback = function(e)
		-- set buffer scoped options
		vim.bo[e.buf].commentstring = "# %s"
	end,
	pattern = { "nix" },
})

-- -- tiltfile set filetype
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = "apache",
--   group = vim.api.nvim_create_augroup('Tiltfile', { clear = true }),
--   callback = function(args)
--     vim.api.nvim_command('setf tiltfile')
--     vim.treesitter.start(args.buf, 'starlark')
--   end
-- })
