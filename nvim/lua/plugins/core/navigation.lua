return {
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() 
      local grapple = require("grapple")

	    grapple.setup({
		    ---@type "debug" | "info" | "warn" | "error"
		    log_level = "warn",

		    ---Can be either the name of a builtin scope resolver,
		    ---or a custom scope resolver
		    ---@type string | Grapple.ScopeResolver
		    scope = "git",

		    ---Window options used for the popup menu
		    popup_options = {
			    relative = "editor",
			    width = 60,
			    height = 12,
			    style = "minimal",
			    focusable = false,
			    border = "single",
		    },

		    integrations = {
			    ---Support for saving tag state using resession.nvim
			    resession = false,
		    },
	    })

	    vim.keymap.set("n", "<leader>e",":GrapplePopup tags<CR>")
	    vim.keymap.set("n", "<leader>a", grapple.toggle)
	    vim.keymap.set("n", "<leader>1", function() grapple.select({key=1})  end)
	    vim.keymap.set("n", "<leader>2", function() grapple.select({key=2})  end)
	    vim.keymap.set("n", "<leader>3", function() grapple.select({key=3})  end)
	    vim.keymap.set("n", "<leader>4", function() grapple.select({key=4})  end)
	    vim.keymap.set("n", "<leader>5", function() grapple.select({key=5})  end)
    end 
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local builtin = require('telescope.builtin')
      local utils = require('telescope.utils')

      require('telescope').setup {
        file_ignore_patterns = { "./node_modules/*", "node_modules", "^node_modules/*", "node_modules/*", "venv/*", "venv",
        "./venv", ".git/" }
      }

      -- opens git_files and fallback to find_files if its not a git directory
      vim.keymap.set('n', '<leader>ff', function()
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
      vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
      vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
      vim.keymap.set('n', '<leader>co', builtin.commands, {})
    end
  }
}
