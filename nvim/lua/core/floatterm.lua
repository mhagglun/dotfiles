local state = {
    floatterm = {
        win = -1,
        buf = -1,
    }
}

local create_float_term = function(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'single',
    }

    local win = vim.api.nvim_open_win(buf, true, win_config)
    return { buf = buf, win = win }
end

local toggle_term = function()
    if not vim.api.nvim_win_is_valid(state.floatterm.win) then
        state.floatterm = create_float_term { buf = state.floatterm.buf }
        if vim.bo[state.floatterm.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floatterm.win)
    end
end


vim.api.nvim_create_user_command("FloatTerm", toggle_term, {})
vim.keymap.set({ "n", "t" }, '<leader>tt', toggle_term, {})
