vim.api.nvim_create_autocmd("InsertEnter", {
    desc = "Fix emmet LSP by updating iskeyword",
    group = vim.api.nvim_create_augroup('emmet-lsp-fix-start', { clear = true }),
    callback = function()
        vim.cmd[[
            set iskeyword+=.
            set iskeyword+=>
            set iskeyword+=+
            set iskeyword+=#
            set iskeyword+=[
            set iskeyword+=]
            set iskeyword+=$
            set iskeyword+=:
            set iskeyword+=<
            set iskeyword+=-
        ]]
        vim.print(vim.bo.iskeyword)
    end,
    buffer=0
})

vim.api.nvim_create_autocmd("InsertLeave", {
    desc = "Fix emmet LSP by updating iskeyword",
    group = vim.api.nvim_create_augroup('emmet-lsp-fix-end', { clear = true }),

    callback = function()
        vim.cmd[[
            set iskeyword-=.
            set iskeyword-=>
            set iskeyword-=+
            set iskeyword-=#
            set iskeyword-=[
            set iskeyword-=]
            set iskeyword-=$
            set iskeyword-=:
            set iskeyword-=<
            set iskeyword-=-
        ]]
        vim.print("Left insert")
    end,
    buffer=0
})


