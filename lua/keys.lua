--- @diagnostic disable: lowercase-global
function map(mode, key, execute)
    vim.keymap.set(mode, key, execute)
end

function nmap(key, execute)
    vim.keymap.set('n', key, execute)
end

function center_movement(key)
    nmap(key, key .. 'zz')
end

function vmap(key, execute)
    vim.keymap.set('x', key, execute) -- as x is strictly visual mode and v ist select AND visual mode
end

function nvmap(key, execute)
    vim.keymap.set({ 'n', 'v' }, key, execute)
end

function imap(key, execute)
    vim.keymap.set('i', key, execute)
end

function tmap(key, execute)
    vim.keymap.set('t', key, execute)
end

-- START using vim integrated stuff
-- START normal mode
nmap("<leader>o", "<cmd>update<cr><cmd>source<cr>") -- source config
nmap("<esc>", "<cmd>nohlsearch<CR>")                -- remove search highlighting
nmap("<leader>v", "ggVG")                           -- select whole file in visual line
nmap("<leader>k", "<cmd>m .-2<cr>")
nmap("<leader>j", "<cmd>m .+1<cr>")
nmap("x", "\"_x")
nmap("X", "\"_X")
nmap("<leader>x", "xp")
nmap("<leader>X", "Xp")
nmap("<leader>be","<cmd>e #<cr>")
nmap("<leader>bs", "<cmd>vertical sf #<cr>")
nmap("<leader>bo", "<cmd>%bd|e#<cr>")
nmap("<leader>ww", "<cmd>vsplit<cr>")
nmap("<leader>wo", "<cmd>only<cr>zz")
nmap("<leader>wb", "<cmd>ball<cr><C-w>=")
nmap("<leader>ö", "<C-]>") -- follow tags

-- START center movement
center_movement("*")
center_movement("#")
center_movement("n")
center_movement("N")
center_movement("G")
center_movement("<C-u>")
center_movement("<C-d>")
center_movement("<C-b>")
center_movement("<C-f>")
-- END center movement
-- END normal mode

-- START visual mode
vmap("<", "<gv")
vmap(">", ">gv")
vmap("<leader>k", ":'<,'>m '<-2<cr>gv") -- moving lines up (: instead of <cmd> because <cmd> does not leave visual mode)
vmap("<leader>j", ":'<,'>m '>+1<cr>gv") -- moving lines down (see above)
-- END visual mode

-- START insert mode

function i_clever_tab()
    -- use tab to cycle through completions if possible, then try to complete the snippet  or
    -- forwards in the snippet, otherwise indent the current line
    if vim.fn.pumvisible() ~= 0 then
        return "<C-n>"
    else
        local ls = require("luasnip")
        if ls.expand_or_locally_jumpable() then
            vim.schedule(function() ls.expand_or_jump(1) end)
        else
            return "<C-T>" -- indent
        end
    end
end
vim.keymap.set("i", "<Tab>", i_clever_tab, {expr=true})

function i_clever_tab_reverse()
    -- go back in the completion list, or jump backwards in a snippet if possible, otherwise,
    -- unindent the current line
    if vim.fn.pumvisible() ~= 0 then
        return "<C-p>"
    else
        local ls = require("luasnip")
        if ls.locally_jumpable(-1) then
            vim.schedule(function() ls.jump(-1) end)
        else
            return "<C-d>"  -- unindent
        end
    end
end
vim.keymap.set("i", "<S-Tab>", i_clever_tab_reverse, {expr=true})

function i_clever_return()
    -- use enter to confirm completion if completion menu is opened
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info()["selected"] ~= -1 then
        return "<C-y>"
    else
        return "<cr>"
    end
end
vim.keymap.set("i", "<return>", i_clever_return, {expr=true})

function ismart_escape()
    -- exits completion if completion list is shown, otherwise esc
    if vim.fn.pumvisible() ~= 0 then
        return "<C-e>"
    else
        return "<esc>"
    end
end
vim.keymap.set("i", "<esc>", ismart_escape, {expr=true})
-- END insert mode

-- START normalvisual mode
nvmap("<leader>r", "<cmd>make<cr>")
nvmap("j", "gj")
nvmap("k", "gk")
-- END normalvisual mode

-- START integrated terminal
local function term_toggle(close)
    close = close or false;
    local is_terminal = vim.bo.buftype == "terminal";
    if is_terminal then
        if close then
            vim.api.nvim_buf_delete(0, { force = true })
        else
            vim.cmd([[b #]])
        end
    else
        local buffers = vim.api.nvim_list_bufs();
        -- vim.print(buffers)
        for _, buf in ipairs(buffers) do
            if vim.bo[buf].buftype == "terminal" then
                vim.api.nvim_set_current_buf(buf);
                return
            end
        end
        vim.cmd [[term]]
    end
end

vim.keymap.set('n', "<leader>t", function() term_toggle(false) end)
vim.keymap.set('n', "<leader>T", function() term_toggle(true) end)

vim.keymap.set('t', "<Esc><Esc>", "<C-\\><C-n>")     -- leave terminal insert with double esc
vim.keymap.set('t', "<S-Esc><S-Esc>", "<C-\\><C-n><cmd>b#<cr>") -- leave terminal insert with double esc
-- END integrated terminal

-- START lsp keycodes
nvmap("<leader>lf", vim.lsp.buf.format)
nvmap("<C-.>", vim.lsp.buf.code_action)

imap("<C-space>", "<C-x><C-o>")

nmap("K", vim.lsp.buf.hover)
nmap("<F2>", vim.lsp.buf.rename)
nmap("<leader>ls", vim.lsp.buf.signature_help)
nmap("<leader>e", vim.diagnostic.open_float)
nmap("<leader>lr", vim.lsp.buf.references)
nmap("<leader>lt", vim.lsp.buf.type_definition)
nmap("<leader>lh", function () vim.lsp.buf.typehierarchy("subtypes") end)
nmap("<leader>lH", function () vim.lsp.buf.typehierarchy("supertypes") end)
nmap("gI", vim.lsp.buf.implementation)
nmap("gd", vim.lsp.buf.definition)
nmap("gD", vim.lsp.buf.declaration)

-- quickfix
nmap("<leader>ql", "<cmd>cwindow<cr>")
nmap("<leader>qP", "<cmd>cfirst<cr>")
nmap("<leader>qp", "<cmd>cprevious<cr>")
nmap("<leader>qq", "<cmd>cc<cr>")
nmap("<leader>qn", "<cmd>cnext<cr>")
nmap("<leader>qN", "<cmd>clast<cr>")
-- END lsp keycodes

-- START luasnip bindings
-- you will find them in lua/plugins/luasnip.lua#config
-- END luasnip bindings

-- START weird mappings

-- END weird mappings
-- END using vim integrated stuff
