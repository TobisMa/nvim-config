
vim.cmd[[setlocal spell]]

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "typst-compile",
    group = vim.api.nvim_create_augroup("typst-compile", {clear=true}),
    pattern = {"*.typ"},
    command = "silent make | cwindow",
})

