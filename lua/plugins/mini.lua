return {
    'nvim-mini/mini.nvim',
    -- use 'main' branch for quicker updates
    version = false,
    config = function ()
        -- autopairs (creating new ()/[]/{} trailing on adding first, disabled as i dont like it inserting when i dont wont it to insert haha
        -- require('mini.pairs').setup({})

        -- expand/collapse arguments
        require('mini.splitjoin').setup({})
    end,
}
