local state = {
    win = -1,
    buf = -1,
}

local function create_term(opts)
    -- create a new buffer or use one passed into opts
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    -- open a new window (horizontal split, bottom)
    vim.cmd('vsplit')
    local win = vim.api.nvim_get_current_win()
    -- vim.api.nvim_win_set_height(win, 15)
    vim.api.nvim_win_set_width(win, 70)
    vim.api.nvim_win_set_buf(win, buf)

    vim.cmd("startinsert")

    return { win = win, buf = buf }
end

local function toggle_term()
    if not vim.api.nvim_win_is_valid(state.win) then
        state = create_term({
            buf = state.buf,
        })
        if vim.bo[state.buf].buftype ~= 'terminal' then
            vim.cmd.term()
        end
    else
        vim.api.nvim_win_hide(state.win)
    end
end

vim.keymap.set({ 'n', 't' }, '<leader>tt', toggle_term, { desc = 'Open/Close terminal window' })
