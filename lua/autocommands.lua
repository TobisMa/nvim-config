-- Setup lazy.nvim

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("lazyvim_autoupdate", { clear=true }),
    callback = function ()
        if require("lazy.stats").has_updates then
            require("lazy").update({ show = false })
        end
    end
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout=50 })
    end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup('remove-hlsearch', { clear = true }),
    command = "nohlsearch",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"*.py"},
    callback = function ()
        vim.schedule(function ()
            vim.keymap.set("n", "<leader>i", "<cmd>PyrightOrganizeImports<cr>", { buffer=true })
        end)
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"*.c", "*.cpp", "*.h"},
    callback = function ()
        vim.schedule(function ()
            vim.keymap.set("n", "<leader>i", "<cmd>echo \"keybind not set\"cr>", { buffer=true })
        end)
    end
})
