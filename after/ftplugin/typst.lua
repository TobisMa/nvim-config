
vim.cmd[[
    setlocal spell
    set formatoptions+=t
]]

vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "typst-compile",
    group = vim.api.nvim_create_augroup("typst-compile", {clear=true}),
    pattern = {"*.typ"},
    callback = function ()
        vim.cmd("silent make | cwindow")
    end,
})

