-- @diagnostic disable: lowercase-global
local function map(mode, key, execute)
    vim.keymap.set(mode, key, execute)
end

local function nmap(key, execute)
    vim.keymap.set('n', key, execute)
end

local function vmap(key, execute)
    vim.keymap.set('x', key, execute) -- as x is strictly visual mode and v ist select AND visual mode
end

local function nvmap(key, execute)
    vim.keymap.set({ 'n', 'v' }, key, execute)
end

local function imap(key, execute)
    vim.keymap.set('i', key, execute)
end

local function center_movement(key)
    map('n', key, key .. "zzzv")
end

local function restore_indentation()
    local line = vim.api.nvim_get_current_line()
    if line:match("^%s*$") then
        local indent = vim.fn.indent(vim.fn.prevnonblank("."))
        if indent > vim.fn.indent(".") then
            vim.schedule(function ()
                vim.fn.feedkeys(string.format("%" .. indent .. "s", ""), "m")
            end)
            return true
        end
    end
    return false
end

local backspace = vim.api.nvim_replace_termcodes('<BS>', true, false, true)

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
nmap("<leader>be", "<cmd>e#<cr>")
nmap("<leader>bs", "<cmd>vertical sf #<cr>")
nmap("<leader>bo", "<cmd>%bd|e#|'\"<cr>")
nmap("<leader>ww", "<cmd>vsplit<cr>")
nmap("<leader>wo", "<cmd>only<cr>zz")
nmap("<leader>wb", "<cmd>ball<cr><C-w>=")
nmap("<leader>ö", "<C-]>") -- follow tags

vim.keymap.set("n", "<leader>a", "<cmd>Lexplore<cr>")

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

local function i_clever_tab()
    -- use tab to cycle through completions if possible, then try to complete the snippet, otherwise indent the current line
    if vim.fn.pumvisible() ~= 0 then
        return "<C-n>"
    elseif vim.snippet.active({direction = 1}) then
        return "<cmd>lua vim.snippet.jump(1)<cr>"
    else
        local ls = require("luasnip")
        if ls.expandable() then
            vim.schedule(function() ls.expand() end)
        elseif vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
        else
            -- restore indentation if line is blank
            if not restore_indentation() then
                return "<C-t>"
            end
        end -- END restore indentation if line is blank
    end
end
vim.keymap.set("i", "<Tab>", i_clever_tab, { expr = true })

local function i_clever_tab_reverse()
    -- go back in the completion list, otherwise, unindent the current line
    if vim.fn.pumvisible() ~= 0 then
        return "<C-p>"
    elseif vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
    else
        return "<C-d>" -- unindent
    end
end
vim.keymap.set("i", "<S-Tab>", i_clever_tab_reverse, { expr = true })

local function i_clever_return()
    -- use enter to confirm completion if completion menu is opened
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info()["selected"] ~= -1 then
        return "<C-y>"
    else
        return "<cr>"
    end
end
vim.keymap.set("i", "<return>", i_clever_return, { expr = true })

local function ismart_escape()
    -- exits completion if completion list is shown, otherwise esc
    if vim.fn.pumvisible() ~= 0 then
        return "<C-e>"
    else
        return "<esc>"
    end
end
vim.keymap.set("i", "<esc>", ismart_escape, { expr = true })

local function ismart_backspace()
    -- if only spaces are left before the cursor clear the whole line and then delete; restore indentation in the new line
    local line = vim.api.nvim_get_current_line()
    if line:match("^%s+$") then
        vim.schedule(function()
            vim.api.nvim_del_current_line()
            local cursor = vim.api.nvim_win_get_cursor(0)
            restore_indentation()
            vim.api.nvim_win_set_cursor(0, {cursor[1], vim.v.maxcol})
        end)
    else
        return "<bs>"
    end
end
vim.keymap.set("i", "<bs>", ismart_backspace, { expr = true })
-- END insert mode

-- START normalvisual mode
nvmap("<leader>r", "<cmd>make<cr>")

-- make behaviour on wrapped lines as expected. that means those commands work for each wrapped line
-- instead of fully jumping to the end
nvmap("j", "gj")
nvmap("k", "gk")
vim.keymap.set({ "n", "v" }, "0", "g0")
vim.keymap.set({ "n", "v" }, "$", "g$")

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

vim.keymap.set('t', "<S-Esc><S-Esc>", "<C-\\><C-n>")        -- leave terminal insert with double esc
vim.keymap.set('t', "<Esc><Esc>", "<C-\\><C-n><cmd>b#<cr>") -- leave terminal insert with double esc and return to last edited buffer
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
nmap("<leader>lh", function() vim.lsp.buf.typehierarchy("subtypes") end)
nmap("<leader>lH", function() vim.lsp.buf.typehierarchy("supertypes") end)
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
