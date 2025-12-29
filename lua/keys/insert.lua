local keys = require("keys.util")

keys.imap("<C-BS>", "<C-w>")
keys.imap("<C-Del>", " <C-o>w<C-w><BS>")


-- advanced key behaviours
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
            -- signature_help()
        else
            -- restore indentation if line is blank
            local line = vim.api.nvim_get_current_line()
            local charPos = vim.fn.getcharpos(".")[3] - 1
            if line:len() <= charPos then
                vim.print(charPos)
                vim.print(line:len())
                vim.print()
                return "<Tab>"
            elseif not keys.restore_indentation() then
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
        -- signature_help()
    else
        return "<C-d>" -- unindent
    end
end
vim.keymap.set("i", "<S-Tab>", i_clever_tab_reverse, { expr = true })

local function i_clever_return()
    -- use enter to confirm completion if completion menu is opened
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info()["selected"] ~= -1 then
        -- use complete done to call signature help
        return "<C-y>"
    else
        return "<cr>"
    end
end
vim.keymap.set("i", "<cr>", i_clever_return, { expr = true })

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
    local _, lnum, charPos, _ = unpack(vim.fn.getcharpos("."))

    if line:sub(0, charPos - 1):match("^%s+$") then
        -- only whitespace left from cursor
        local prevIndent = vim.fn.indent(vim.fn.prevnonblank(lnum - 1))
        local currentIndent = vim.fn.indent(".")
        if prevIndent > currentIndent then
            -- indentation of current line smaller than of the previous (nonblank) line
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<C-w><BS>", true, false, true),
                "m",
                false
            )
            vim.schedule(keys.restore_indentation)
            return ""
        end
        -- remove indent instead of line
    end
    return "<BS>"
end
vim.keymap.set("i", "<bs>", ismart_backspace, { expr = true })
