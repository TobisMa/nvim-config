return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            always_show_bufferline = true,
            show_buffer_icons = true,
            show_buffer_close_icons = false,
            show_close_icon = false,
            modified_icon = "~",
            show_tab_indicators = true,
            -- separator_style = "thin",
            numbers = function(opts)
                return opts.ordinal
            end,
            name_formatter = function (buf)
                local max_length = 22 - tostring(buf.bufnr):len()
                local name = buf.name
                if name:len() > max_length then
                    name = name:sub(1, max_length - 1) .. "…"
                end
                return string.format("%s (%s)", name, buf.bufnr)
            end,
            max_name_length=25,
            diagnostics = "nvim_lsp"
        },
    }
}
