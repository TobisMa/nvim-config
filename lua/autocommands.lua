-- highlight text when copying/yanking
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 50 })
    end,
})

-- remove the highlight of the last search/replace-search when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup('remove-hlsearch', { clear = true }),
    command = "nohlsearch",
})

vim.api.nvim_create_autocmd({ "OptionSet", "UIEnter" }, {
    group = vim.api.nvim_create_augroup('indent-guides', { clear = true }),
    callback = function()
        if vim.bo.shiftwidth <= 0 then
            return
        end
        local lms = "" for _ = 2, vim.bo.shiftwidth do lms = lms .. " " end
        vim.opt.listchars = {
            leadmultispace = "|" .. lms,
            trail = "·",
            nbsp = "␣",
            tab = "» "
        }
    end,
})

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Remove trailing whitespace (excluing line from cursor if it is a whitespace line)",
    group = vim.api.nvim_create_augroup("remove-trailing", { clear = true }),
    pattern = { "*" },
    callback = function()
        local pos = vim.fn.getpos(".")
        local line = vim.api.nvim_get_current_line()
        vim.cmd [[silent! %s/\(\S\?\)\s\+$/\1/]]
        if line:match("^%s*$") then
            vim.api.nvim_set_current_line(line)
        end
        vim.fn.setpos(".", pos)
    end,
})

-- lsp latex keybind
vim.api.nvim_create_autocmd('LspAttach', {
    pattern = { "*.tex", "*.latex" },
    group = vim.api.nvim_create_augroup('lsp.texlab-environment-swap', { clear = true }),
    command = "nmap <buffer> <F2> <cmd>LspTexlabChangeEnvironment<cr>",
})


-- lsp c commands
vim.api.nvim_create_autocmd('LspAttach', {
    pattern = { "*.c", "*.cpp", "*.hpp", "*.h" },
    group = vim.api.nvim_create_augroup('lsp.c/cpp', { clear = true }),
    callback = function()
        vim.keymap.set({ "n", "i" }, "<C-S-K>", "<cmd>LspClangdShowSymbolInfo<cr>")
        vim.keymap.set({ "n", "i" }, "<C-ö>", "<cmd>LspClangdSwitchSourceHeader<cr>")
        vim.keymap.set({ "n" }, "<leader>I", "<cmd>LspClangdSwitchSourceHeader<cr>")
    end,
})
