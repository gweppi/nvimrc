-- telescope for easy fuzzy finding
return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()
        local builtin = require('telescope.builtin')
        -- search files in local directory
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files in current directory with Telescope' })
        -- search through open buffers
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find open buffers in current neovim instance' })
        -- search through help tags
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find available help tags' })
        -- list recently open files
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Show recently open files' })
        -- search files in nvim config directory
        local function find_nvim_files()
            builtin.find_files({
                cwd = vim.fn.stdpath('config'),
            })
        end

        vim.keymap.set('n', '<leader>fn', find_nvim_files, { desc = 'Find nvim config files with Telescope' })
    end,
}
