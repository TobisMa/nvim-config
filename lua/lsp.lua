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

local auto_trigger = {
    -- put fieltypes here
    lua = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (e)
        local client = assert(vim.lsp.get_client_by_id(e.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, e.buf, { autotrigger = auto_trigger[vim.bo[0].ft] or false })
        end
        local client = assert(vim.lsp.get_client_by_id(e.data.client_id))

        if client:supports_method('textDocument/completion') then
          -- Optional: trigger autocompletion on EVERY keypress. May be slow!
          local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
          client.server_capabilities.completionProvider.triggerCharacters = chars
          vim.lsp.completion.enable(true, client.id, e.buf, {autotrigger = true})
        end
    end
})

vim.diagnostic.config({
  virtual_text = true
})
