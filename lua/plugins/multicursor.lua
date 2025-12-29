return {
    "https://github.com/jake-stewart/multicursor.nvim",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()
        vim.g.multiCursors = false

        local set = vim.keymap.set

        set({'n', 'x'}, "<leader>q", mc.toggleCursor)
        set({"n", "x"}, "<C-n>", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<C-S-n>", function() mc.matchAddCursor(-1) end)
        set("n", "<leader>m", mc.restoreCursors)

        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "H", mc.prevCursor)
            layerSet({"n", "x"}, "L", mc.nextCursor)

            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)
            layerSet({"n", "x"}, "<C-q>", mc.toggleCursor)

            layerSet("x", "S", mc.splitCursors)
            layerSet("x", "M", mc.matchCursors)

            layerSet("x", "I", mc.insertVisual)
            layerSet("x", "A", mc.appendVisual)

            layerSet({"n", "x"}, "|", mc.alignCursors)

            -- TODO: mc.operator (view :h multicursor-operator)

            layerSet("n", "<Esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)
        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}
