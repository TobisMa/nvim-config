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

-- configure space indentation and update on OptionSet
vim.api.nvim_create_autocmd({ "OptionSet", "UIEnter" }, {
    group = vim.api.nvim_create_augroup('indent-guides', { clear = true }),
    callback = function()
        if vim.bo.shiftwidth <= 0 then
            return
        end
        local lms = "" for _ = 2, vim.bo.shiftwidth do lms = lms .. " " end
        vim.opt.listchars = {
            leadmultispace = "│" .. lms,
            trail = "·",
            nbsp = "␣",
            tab = "» "
        }
    end,
})

-- store nvim session
vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("store-session", { clear= true}),
    callback = function ()
        if not vim.v.dying then
            vim.cmd[[mksession .session.vim]]
        elseif #vim.api.nvim_list_bufs() >= 15 then
            local res = vim.fn.input("Save session (y/N):")
            if res == "y" then
                vim.cmd[[mksession! .session.vim]]
            end
        end
    end
})

-- load nvim session
vim.api.nvim_create_autocmd("UIEnter", {
    group = vim.api.nvim_create_augroup("load-session", { clear= true}),
    callback = function ()
        if vim.fn.filereadable(vim.fn.expand(".session.vim")) == 1 then
            local res = vim.fn.input("Load session (y/N):")
            if res == "y" then
                vim.schedule(function ()
                    vim.cmd[[source .session.vim]]
                    vim.cmd[[silent! !rm .session.vim]]
                end)
            end
        end
    end
})

-- keep cursor position in file
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function (args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local lines = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= lines then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function ()
                vim.cmd[[normal! zz]]
            end)
        end
    end
})


-- vim.api.nvim_create_autocmd("InsertEnter", {
--     group = vim.api.nvim_create_augroup('indent-guides', { clear = true }),
--     callback = function ()
--         vim.api.nvim_buf_set_extmark
--     end
-- })

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
        vim.keymap.set({ "n" }, "<leader>i", "<cmd>LspClangdSwitchSourceHeader<cr>")

        -- remove double > or " when inserting header
        vim.api.nvim_create_autocmd('CompleteDone', {
            group = vim.api.nvim_create_augroup('lsp.c/cpp-header1', { clear = true }),
            callback = function ()
                local line = vim.api.nvim_get_current_line();
                if line:find("^#include <([a-zA-Z0-9_/.+-]+)>>$") then
                    local cur = vim.fn.getcurpos(0)
                    vim.cmd[[s/^#include <\(\S\+\)>>$/#include <\1>]]
                    vim.fn.setpos(".", cur)
                end
                if line:find("^#include \"([a-zA-Z0-9_/.+-]+)\"\"$") then
                    local cur = vim.fn.getcurpos(0)
                    vim.cmd[[s/^#include \"\(\S\+\)\"\"$/#include \"\1\"]]
                    vim.fn.setpos(".", cur)
                end
            end,
            buffer=0
        })
    end,
})
