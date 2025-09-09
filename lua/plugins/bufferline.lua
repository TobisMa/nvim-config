return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                always_show_bufferline = true,
                show_buffer_icons = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                modified_icon = "~",
                show_tab_indicators = true,
                -- separator_style = "thin",
                numbers = function(opts)
                    return opts.id
                end,
            },
        })
    end
}
