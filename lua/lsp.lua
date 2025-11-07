vim.lsp.enable({
    "lua_ls",
    "rust-analyzer",
    "pyright",
    "ty",
    "jdtls",
    "clangd",
    "tinymist",
    "html",
    "cssls",
    "eslint",
    "emmet_language_server",
    "jinja_lsp",
    "texlab",
    "ts_ls"
})


vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("tobisma.lsp", {clear = true}),
    callback = function (e)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        local client = assert(vim.lsp.get_client_by_id(e.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            local chars = {"\\", "$", "#", "<", "."};
            for i = 65, 90 do table.insert(chars, string.char(i)) end
            for i = 97, 122 do table.insert(chars, string.char(i)) end
            -- above three lines may be changed to (untested):
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, e.buf, {autotrigger = true})

            -- vim.api.nvim_create_autocmd('CompleteDone', {
            --     group = vim.api.nvim_create_augroup('tobisma.lsp.completion', { clear = true }),
            --     callback = vim.lsp.buf.signature_help,
            --     buffer=0
            -- })
        end
    end
})

vim.lsp.inlay_hint.enable(true, nil)  -- enable inlay hints for all buffers

vim.diagnostic.config({
  virtual_text = true
})
