
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons", opt = true,
        "yeddaif/neovim-purple",
    },
    config = function()
        require("lualine").setup {
            options = {
                theme = "auto",
                globalstatus = false,
            }
        }
    end
}
