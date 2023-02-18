local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

require('telescope').setup {
    file_ignore_patterns = { "./node_modules/*", "node_modules", "^node_modules/*", "node_modules/*", "venv/*", "venv",
        "./venv", ".git/" }
}

-- opens git_files and fallback to find_files if its not a git directory
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
    })
end)

vim.keymap.set('n', '<leader>pg', function()
    local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
    if ret == 0 then
        builtin.git_files({
        })
    else
        builtin.find_files({
        })
    end
end)

--vim.keymap.set('n', '<leader>ps', function()
--builtin.grep_string({ search = vim.fn.input("Grep > ") });
--end)
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pgs', builtin.git_status, {})
vim.keymap.set('n', '<leader>c', builtin.commands, {})
