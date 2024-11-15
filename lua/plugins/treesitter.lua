
return { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects"
    },
    opts = {
        ensure_installed = { "c", "cpp", "go", "lua", "python", "javascript", "bash", "html", "css"},
        -- ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', "javascript", "python", "css" },
        auto_install = true,

        highlight = {
            enable = true,
            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-Space>",
                node_decremental = "<C-S-Space>",
                scope_incremental = "<C-s>"
            }
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- ['a]m'] = '@function.outer', -- TODO
                    -- ['iäm'] = '@function.inner',
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                    ['al'] = '@loop.outer',
                    ['il'] = '@loop.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = '@function.outer',
                    ['äm'] = '@function.outer',
                    [']c'] = '@class.outer',
                    ['äc'] = '@class.outer',
                    [']a'] = '@parameter.inner',
                    ['äa'] = '@parameter.inner',
                    [']l'] = '@loop.outer',
                    ['äl'] = '@loop.outer',
                    [']B'] = '@block.outer',
                    ['äB'] = '@block.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    ['äM'] = '@function.outer',
                    [']C'] = '@class.outer',
                    ['äC'] = '@class.outer',
                    [']A'] = '@parameter.inner',
                    ['äA'] = '@parameter.inner',
                    [']L'] = '@loop.outer',
                    ['äL'] = '@loop.outer',
                    [']b'] = '@block.outer',
                    ['äb'] = '@block.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['üm'] = '@function.outer',
                    ['[c'] = '@class.outer',
                    ['üc'] = '@class.outer',
                    ['[a'] = '@parameter.inner',
                    ['üa'] = '@parameter.inner',
                    ['[l'] = '@loop.outer',
                    ['ül'] = '@loop.outer',
                    ['[b'] = '@block.outer',
                    ['üb'] = '@block.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['üM'] = '@function.outer',
                    ['[C'] = '@class.outer',
                    ['üC'] = '@class.outer',
                    ['[A'] = '@parameter.inner',
                    ['üA'] = '@parameter.inner',
                    ['[L'] = '@loop.outer',
                    ['üL'] = '@loop.outer',
                    ['[B'] = '@block.outer',
                    ['üB'] = '@block.outer',
                },
                -- goto_next_start = {
                --     [']f'] = '@function.outer',
                --     [']c'] = '@class.outer',
                --     [']a'] = '@parameter.inner',
                -- },
                -- goto_next_end = {
                --     [']F'] = '@function.outer',
                --     [']C'] = '@class.outer',
                --     [']A'] = '@parameter.inner',
                -- },
                -- goto_previous_start = {
                --     ['[f'] = '@function.outer',
                --     ['[c'] = '@class.outer',
                --     ['[a'] = '@parameter.inner',
                -- },
                -- goto_previous_end = {
                --     ['[F'] = '@function.outer',
                --     ['[C'] = '@class.outer',
                --     ['[A'] = '@parameter.inner',
                -- },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },
        },
    },
    config = function(_, opts)
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup(opts)

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
}
