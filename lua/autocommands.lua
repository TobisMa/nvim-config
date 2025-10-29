-- highlight text when copying/yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 50 })
    end,
})

-- remove the highlight of the last search/replace-search when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup('remove-hlsearch', { clear = true }),
    command = "nohlsearch",
})

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Remove trailing whitespace (excluing line from cursor if it is a whitespace line)",
    group = vim.api.nvim_create_augroup("remove-trailing", { clear = true }),
    pattern = { "*" },
    callback = function()
        local pos = vim.fn.getpos(".")
        local line = vim.api.nvim_get_current_line()
        vim.cmd [[silent! %s/\(\S\?\)\s\+$/\1/]]
        if line:match("^%s*$") then
            vim.api.nvim_set_current_line(line)
        end
        vim.fn.setpos(".", pos)
    end,
})

-- lsp trigger for latex
vim.api.nvim_create_autocmd('LspAttach', {
    pattern={"*.tex", "*.latex"},
    group = vim.api.nvim_create_augroup('texlab-environment-swap', {clear=true}),
    command = "nmap <buffer> <F2> <cmd>LspTexlabChangeEnvironment<cr>",
})
