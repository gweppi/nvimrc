-- colorscheme
return {
    -- Disabled for now as i got distracted by the colors of the brackets haha
    -- {
    --     'HiPhish/rainbow-delimiters.nvim',
    -- },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        opts = {
            background = {
                light = 'latte',
                dark = 'mocha',
            },
            term_colors = true,
        },
        config = function()
            vim.cmd.colorscheme('catppuccin')
        end,
    }
}
