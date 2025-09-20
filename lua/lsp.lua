vim.lsp.enable({
    "lua_ls",
    "rust-analyzer",
    "pyright",
    "jdtls",
    "clangd",
    "tinymist",
    "html",
    "cssls",
    "eslint",
    "emmet_language_server"
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (e)
        local client = assert(vim.lsp.get_client_by_id(e.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, e.buf, { autotrigger = true })
        end
    end
})

vim.diagnostic.config({
  virtual_text = true
})
