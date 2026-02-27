-- treesitter for parsing code in file, shows better highlighting
return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        -- all supported languages can be found on https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
        local intalled_parsers = {
            'lua',
            'python',
            'markdown',
            'markdown_inline',
            'html',
            'css',
            'java',
            'javadoc',
            'json',
            'typescript',
            'javascript',
            'go',
        }
        -- install treesitter parsers
            require('nvim-treesitter').install(intalled_parsers)
        -- setup highlighting and indenting
        vim.api.nvim_create_autocmd('FileType', {
            pattern = intalled_parsers,
            group = vim.api.nvim_create_augroup('treesitter-highlighting', { clear = true }),
            callback = function()
                vim.treesitter.start()
            end
        })
    end
}
