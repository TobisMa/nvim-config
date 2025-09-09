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
