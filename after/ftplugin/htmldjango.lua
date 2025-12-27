vim.api.nvim_create_autocmd("CompleteDonePre", {
    group = vim.api.nvim_create_augroup( "tobisma.emmet-fix", { clear = true }),
    callback = function (e)
        vim.cmd[[ set iskeyword+=> ]]
        -- vim.print(e)
        -- vim.print(vim.v.completed_item)
    end,
    buffer = 0
})
vim.api.nvim_create_autocmd("CompleteDone", {
    group = vim.api.nvim_create_augroup( "tobisma.emmet-fix", { clear = true }),
    callback = function (e)
        vim.schedule(function() vim.cmd[[ set iskeyword-=> ]] end)
        -- vim.print(e)
        -- vim.print(vim.v.completed_item)
    end,
    buffer = 0
})
