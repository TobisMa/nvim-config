-- plugin keymap is in the plugins foler in the plugin conf

vim.keymap.set('n', "<Esc>", "<cmd>nohlsearch<CR>") -- remove search highlighting
vim.keymap.set('n', "<cr>", "<cr>zzzv")
vim.keymap.set('n', "<leader>cd", ":cd %:h<cr>")
vim.keymap.set('n', "<leader>o", "<cmd>Neotree source=document_symbols toggle right reveal<cr>")
vim.keymap.set('n', "<leader>g", "<cmd>Neotree source=git_status float<cr>")
vim.keymap.set('n', "<leader>f", "<cmd>Neotree source=filesystem toggle left reveal<cr>")
vim.keymap.set('n', "<leader><leader>b", "<cmd>Neotree source=buffers float<cr>")
vim.keymap.set('n', "<leader>y", "mfggVGy'f")
vim.keymap.set('n', "<leader>v", "ggVG")
vim.keymap.set('v', "<", "<gv")
vim.keymap.set('v', ">", ">gv")
vim.keymap.set({'n', "v"}, "j", "gj")
vim.keymap.set({'n', "v"}, "k", "gk")
vim.keymap.set('n', "dy", "0D")
vim.keymap.set('n', "<leader>m", "<cmd>marks<enter>")
vim.keymap.set('n', "<leader>M", "<cmd>marks 'ABCDEFGHIJKLMNOPQRSTUVXYZ<cr>")
vim.keymap.set('t', "<Esc><Esc>", "<C-\\><C-n>")
vim.keymap.set('t', "<S-Esc><S-Esc>", "<C-\\><C-n>")
vim.keymap.set('n', "<leader>t", "<cmd>term<cr>A")
vim.keymap.set('n', "<leader>,", "\"\"diWo<C-R>=stdpath('config')<<CR>/<C-R>=expand('%:e')<CR>/<Esc>\"\"pA.template<Esc>")
vim.keymap.set('n', "<leader>e", vim.diagnostic.open_float)
vim.keymap.set('n', "<leader>q", vim.diagnostic.setloclist)


-- local remove_trailing_spaces_command = "mfkVgg<cmd>keeppatterns '<,'>s/\\s\\+$//e<cr>'fjVG<cmd>keeppatterns '<,'>s/\\s\\+$//e<cr>'f<cmd>echo \"Removed trailing spaces\"<cr>"
-- vim.keymap.set('n', "<leader>f", remove_trailing_spaces_command)

local function center_movement(key)
    vim.keymap.set('n', key, key .. "zzzv")
end
center_movement("*")
center_movement("#")
center_movement("n")
center_movement("N")
center_movement("G")
center_movement("<C-u>")
center_movement("<C-d>")
center_movement("<C-b>")
center_movement("<C-f>")

vim.keymap.set("n", "]f", "<nop>")
vim.keymap.set("n", "]F", "<nop>")