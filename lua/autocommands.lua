-- START general
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

vim.api.nvim_create_autocmd("BufNew", {
    desc = "load lsp keymaps",
    group = vim.api.nvim_create_augroup("lsp-mappings", {clear=true}),
    pattern = {"*"},
    callback = function()
        lsp_mappings()
    end,
})
-- END general
