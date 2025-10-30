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
    "emmet_language_server",
    "jinja_lsp",
    "texlab"
})


vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("tobisma.lsp", {clear = true}),
    callback = function (e)
        local client = assert(vim.lsp.get_client_by_id(e.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {"\\", "$", "#", "<"};
            for i = 65, 90 do table.insert(chars, string.char(i)) end
            for i = 97, 122 do table.insert(chars, string.char(i)) end
            -- above three lines may be changed to (untested):
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, e.buf, {autotrigger = true})
        end
    end
})

vim.diagnostic.config({
  virtual_text = true
})
