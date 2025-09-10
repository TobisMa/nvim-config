return {
    "https://github.com/L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
        require("luasnip").setup({ enable_autosnippets = true })
        require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
        local ls = require("luasnip")

        local function smart_expand()
            if vim.fn.pumvisible() == 0 then
                return ls.expand_or_jump(1)
            end
        end
        vim.keymap.set("i", "<C-e>", smart_expand, {silent=true, expr=true, noremap=false})
        vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })
    end
}
