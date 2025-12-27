return {
    "xyaman/dired.nvim",
    branch = "feature/override-cwd-opt",
    lazy = true,
    dependencies = {
        "MunifTanjim/nui.nvim"
    },
    opts = {
        path_separator = "/",
        show_banner = false,
        show_icons = false,
        show_hidden = true,
        show_dot_dirs = true,
        show_colors = true,
        override_cwd = false,
        keybinds = {
            dired_enter = "<CR>",
            dired_back = "_",
            dired_up = "-",
            dired_rename = "R",
            dired_quit = "q",
        }

    },
    keys = {
        {"<TAB>", "<cmd>Dired<cr>", {desc = "Opens dired.nvim filebrowser"}},
        {"<leader>a", "<cmd>vs | Dired<cr>", {desc = "Opens dired.nvim filebrowser in vertical split right"}},
    }
}
