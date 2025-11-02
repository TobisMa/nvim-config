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

local function smap(key, execute, opts)
    vim.keymap.set('s', key, execute, opts)
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
nmap("x", "\"_x")  -- don't save the character on the clipboard
nmap("X", "\"_X")  -- don't save the character on the clipboard
nmap("<leader>x", "xp")  -- swap the right character with the character under the cursor
nmap("<leader>X", "Xp")  -- swap the left character with the character under the cursor
nmap("<leader>be", "<cmd>e#<cr>")  -- go to previous buffer (if it had a name)
nmap("<leader>bs", "<cmd>vertical sf #<cr>")  -- split current buffer with previous vertically
nmap("<leader>bo", "<cmd>%bd|e#|'\"<cr>")  -- close every other buffer than the current
nmap("<leader>ww", "<cmd>vsplit<cr>")  -- split current buffer into two windows. go to the new window
nmap("<leader>wo", "<cmd>only<cr>zz")  -- show only the buffer of the current window (closes all other windows)
nmap("<leader>wb", "<cmd>ball<cr><C-w>=")  -- show every opened buffer
nmap("<leader>ö", "<C-]>") -- follow tags

vim.keymap.set("n", "<leader>a", "<cmd>Lexplore<cr>")

-- START center movement
-- below commands force the cursor to stay on the middle of the screen
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
vmap("<", "<gv")  -- indenting out and keep selection
vmap(">", ">gv")  -- indent and keep selection
vmap("<leader>k", ":'<,'>m '<-2<cr>gv") -- moving lines up (: instead of <cmd> because <cmd> does not leave visual mode)
vmap("<leader>j", ":'<,'>m '>+1<cr>gv") -- moving lines down (see above)
-- END visual mode

-- START select mode
local function snippet_move(dir, key)
    if vim.snippet.active{direction = dir} then
        vim.snippet.jump(dir)
    else
        return key
    end
end
smap("<Tab>", function () snippet_move(1, "<Tab>") end, {})
smap("<S-Tab>", function () snippet_move(-1, "<S-Tab>") end, {})
-- END select mode

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
                return "<C-t>" -- indent line
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
vim.keymap.set("i", "<cr>", i_clever_return, { expr = true, remap=true })

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
            vim.api.nvim_win_set_cursor(0, {math.max(1, cursor[1] - 1), vim.v.maxcol}) -- fix cursor position
            restore_indentation()
        end)
    else
        return "<bs>"
    end
end
vim.keymap.set("i", "<bs>", ismart_backspace, { expr = true })
-- END insert mode

-- START normalvisual mode
nvmap("<leader>r", "<cmd>make<cr>")  -- call the set makeprg (set in after/ftplugin/<lang>.lua). QuickFix list can be used then. See below in the LSP section

-- make behaviour on wrapped lines as expected. that means those commands work for each wrapped line
-- instead of fully jumping to the end
nvmap("j", "gj")  -- make j behave the same as in wrapped lines
nvmap("k", "gk")  -- make k behave the same as in wrapped lines
vim.keymap.set({ "n", "v" }, "0", "g0") -- make 0 behave the same in wrapped lines
vim.keymap.set({ "n", "v" }, "$", "g$") -- make $ behave the same as in wrapped lines

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

vim.keymap.set('n', "<leader>t", function() term_toggle(false) end)  -- go to terminal buffer (creates a terminal if no terminal exists yet)
                                                                     -- if terminal buffer go back to previous buffer
vim.keymap.set('n', "<leader>T", function() term_toggle(true) end)   -- close terminal

vim.keymap.set('t', "<S-Esc><S-Esc>", "<C-\\><C-n>")        -- leave terminal insert mode with double esc
vim.keymap.set({'t'}, "<Esc><Esc>", "<C-\\><C-n><cmd>b#<cr>") -- leave terminal with double esc and return to last edited buffer
-- END integrated terminal

-- START lsp keycodes
nvmap("<leader>lf", vim.lsp.buf.format)  -- format code if LSP has formatter
nvmap("<C-.>", vim.lsp.buf.code_action)  -- code action (like IntelliJ Alt+enter)

imap("<C-space>", "<C-x><C-o>")  -- trigger autocompletion

nmap("K", vim.lsp.buf.hover)  -- give hover info of functions/methods/variables/...
nmap("<C-k>", "K")  -- move calling keywordprg to c-k (default would be K)
nmap("<F2>", vim.lsp.buf.rename)  -- rename variable/function/...
nmap("<leader>ls", vim.lsp.buf.signature_help)  -- signature help in a floating window
nmap("<leader>e", vim.diagnostic.open_float)  -- shows error messages in a floating window if they exist at current position
nmap("<leader>lr", vim.lsp.buf.references)  -- open references associated with variable/function in QuickFix list
nmap("<leader>lt", vim.lsp.buf.type_definition) -- go to type definition/declaration
nmap("<leader>lh", function() vim.lsp.buf.typehierarchy("subtypes") end)  -- list child classes (generally subtypes) in the quickfix list
nmap("<leader>lH", function() vim.lsp.buf.typehierarchy("supertypes") end)  -- -- list child classes (generally subtypes) in the quickfix list
nmap("gI", vim.lsp.buf.implementation)  -- shows implementations for the symbol under cursor in the quickfix list (go to symbol if only one implementation exists)
nmap("gd", vim.lsp.buf.definition)  -- go to defintion of the symbol under the cursor (not declaration)
nmap("gD", vim.lsp.buf.declaration)  -- go to declaration of the symbol under the cursor (not definition)

-- quickfix
nmap("<leader>ql", "<cmd>cwindow<cr>")  -- open quickfix list if items exist (nothing happens if there are no items)
nmap("<leader>qP", "<cmd>cfirst<cr>")   -- go to first entry in the quickfix list
nmap("<leader>qp", "<cmd>cprevious<cr>")  -- go to previous quickfix list entry
nmap("<leader>qq", "<cmd>cc<cr>")  -- go to current quickfix list entry (last selected)
nmap("<leader>qn", "<cmd>cnext<cr>")  -- go to next quickfix list entry
nmap("<leader>qN", "<cmd>clast<cr>")  -- go to last entry in the quickfix list
-- END lsp keycodes

-- START luasnip bindings
-- you will find them in lua/plugins/luasnip.lua#config
-- END luasnip bindings

-- START weird mappings

-- END weird mappings
-- END using vim integrated stuff
