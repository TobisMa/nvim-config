return {
    "https://github.com/jake-stewart/multicursor.nvim",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()
        vim.g.multiCursors = false

        local set = vim.keymap.set

        set({'n', 'x'}, "<C-q>", mc.toggleCursor)
        set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
        set({"n", "v"}, "<leader>A", mc.matchAllAddCursors)

        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "H", mc.prevCursor)
            layerSet({"n", "x"}, "L", mc.nextCursor)

            set({"n", "x"}, "K", function() mc.lineAddCursor(-1) end)
            set({"n", "x"}, "J", function() mc.lineAddCursor(1) end)
            set({"n", "x"}, "<C-k>", function() mc.lineSkipCursor(-1) end)
            set({"n", "x"}, "<C-j>", function() mc.lineSkipCursor(1) end)

            set({"n", "x"}, "n", function() mc.matchAddCursor(1) end)
            set({"n", "x"}, "N", function() mc.matchAddCursor(-1) end)
            set({"n", "x"}, "<C-n>", function() mc.matchSkipCursor(1) end)
            set({"n", "x"}, "<C-S-n>", function() mc.matchSkipCursor(-1) end)

            layerSet({"n", "x"}, "<leader>q", mc.deleteCursor)

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
