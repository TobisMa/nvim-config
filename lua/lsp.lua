vim.lsp.enable({"lua_ls", "rust-analyzer", "pyright", "jdtls", "clangd", "tinymist"})

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

function nmap(key, execute)
    vim.keymap.set('n', key, execute)
end

function vmap(key, execute)
    vim.keymap.set('x', key, execute) -- as x is strictly visual mode and v ist select AND visual mode
end

function nvmap(key, execute)
    vim.keymap.set({'n', 'v'}, key, execute)
end

function imap(key, execute)
    vim.keymap.set('i', key, execute)
end


