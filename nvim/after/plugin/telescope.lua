local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

require('telescope').setup {
    file_ignore_patterns = { "./node_modules/*", "node_modules", "^node_modules/*", "node_modules/*", "venv/*", "venv",
        "./venv", ".git/" }
}

-- opens git_files and fallback to find_files if its not a git directory
vim.keymap.set('n', '<leader>pf', function()
    local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
    if ret == 0 then
        opts = opts or {}
        opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        builtin.find_files(opts)
    else
        builtin.find_files({
        })
    end
end)
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
vim.keymap.set('n', '<leader>co', builtin.commands, {})
