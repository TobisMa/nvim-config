return {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
        dependencies_bin = { ['tinymist'] = 'tinymist' },
        follow_cursor = false,
        get_root = function(path_of_main_file)
            local root = os.getenv 'TYPST_ROOT'
            if root then
                return root
            end
            return vim.fn.getcwd(-1, -1)  -- open nvim with in project folder
        end,
    },
}
