M = {}

function M.map(mode, key, execute)
    vim.keymap.set(mode, key, execute)
end

function M.nmap(key, execute)
    vim.keymap.set('n', key, execute)
end

function M.vmap(key, execute)
    vim.keymap.set('x', key, execute) -- as x is strictly visual mode and v ist select AND visual mode
end

function M.smap(key, execute)
    vim.keymap.set('s', key, execute)
end

function M.nvmap(key, execute)
    vim.keymap.set({ 'n', 'v' }, key, execute)
end

function M.imap(key, execute)
    vim.keymap.set('i', key, execute)
end

function M.center_movement(key)
    M.map('n', key, key .. "zzzv")
end

function M.restore_indentation()
    local line = vim.api.nvim_get_current_line()
    if line:match("^%s*$") then
        local indent = vim.fn.indent(vim.fn.prevnonblank("."))
        if indent > vim.fn.indent(".") then
            vim.schedule(function ()
                vim.fn.feedkeys(string.format("%" .. indent .. "s", ""), "m")
            end)
            return true
        end
    end
    return false
end

function M.snippet_move(dir, key)
    if vim.snippet.active{direction = dir} then
        vim.snippet.jump(dir)
        -- signature_help()
    else
        return key
    end
end

M.backspace = vim.api.nvim_replace_termcodes('<BS>', true, false, true)

return M
