vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Replace tabs with 4 spaces",
    group = vim.api.nvim_create_augroup("replace-tab-with-space", {clear=true}),
    pattern = {"*.java"},
    command = "silent! %s/     /    /g",
})
