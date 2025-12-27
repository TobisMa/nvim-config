
local function term_toggle(close)
    close = close or false;
    local is_terminal = vim.bo.buftype == "terminal";
    if is_terminal then
        if close then
            vim.api.nvim_buf_delete(0, { force = true })
        else
            vim.cmd([[b #]])
        end
    else
        local buffers = vim.api.nvim_list_bufs();
        -- vim.print(buffers)
        for _, buf in ipairs(buffers) do
            if vim.bo[buf].buftype == "terminal" then
                vim.api.nvim_set_current_buf(buf);
                return
            end
        end
        vim.cmd [[term]]
    end
end

vim.keymap.set('n', "<leader>t", function() term_toggle(false) end)  -- go to terminal buffer (creates a terminal if no terminal exists yet)
                                                                     -- if terminal buffer go back to previous buffer
vim.keymap.set('n', "<leader>T", function() term_toggle(true) end)   -- close terminal

vim.keymap.set('t', "<S-Esc><S-Esc>", "<C-\\><C-n>")        -- leave terminal insert mode with double esc
vim.keymap.set('t', "<Esc><Esc>", "<C-\\><C-n><cmd>b#<cr>") -- leave terminal with double esc and return to last edited buffer
