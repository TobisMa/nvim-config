vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout=50 })
    end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup('remove-hlsearch', { clear = true }),
    command = "nohlsearch",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Remove trailing whitespace (excluing line from cursor if it is a whitespace line)",
    group = vim.api.nvim_create_augroup("remove-trailing", {clear=true}),
    pattern = {"*"},
    callback = function ()
        local line = vim.api.nvim_get_current_line()
        vim.cmd[[silent! %s/\(\S\)\s\+$/\1/]]
        if line:match("^%s*$") then
            vim.api.nvim_set_current_line(line)
        end
        vim.cmd[[normal $]]
    end,
})
-- vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace("indent-guides"), 33, 0, {virt_text={{"│", "indent-guides"}}, virt_text_win_col=4})
-- vim.api.nvim_buf_del_extmark(0,


