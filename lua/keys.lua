function map(mode, key, execute)
	vim.keymap.set(mode, key, execute)
end

function nmap(key, execute)
	vim.keymap.set('n', key, execute)
end

function center_movement(key)
    nmap(key, key .. 'zz')
end

function vmap(key, execute)
	vim.keymap.set('x', key, execute) -- as x is strictly visual mode and v ist select AND visual mode
end

function nvmap(key, execute)
    vim.keymap.set({'n', 'v'}, key, execute)
end

function imap(key, execute)
	vim.keymap.set('i', key, execute)
end

function tmap(key, execute)
	vim.keymap.set('t', key, execute)
end

-- START using vim integrated stuff
-- START normal mode
nmap("<leader>o", "<cmd>update<cr><cmd>source<cr>") -- source config
nmap("<esc>", "<cmd>nohlsearch<CR>") -- remove search highlighting
nmap("<leader>v", "ggVG") -- select whole file in visual line
nmap("<leader>k", "<cmd>m .-2<cr>")
nmap("<leader>j", "<cmd>m .+1<cr>")
nmap("x", "\"_x")
nmap("X", "\"_X")
nmap("<leader>le", "<cmd>e #<cr>")
nmap("<leader>ls", "<cmd>vertical sf #<cr>")
nmap("<leader>ö", "%m[%v<C-g>")

-- START center movement
center_movement("*")
center_movement("#")
center_movement("n")
center_movement("N")
center_movement("G")
center_movement("<C-u>")
center_movement("<C-d>")
center_movement("<C-b>")
center_movement("<C-f>")
-- END center movement
-- END normal mode

-- START visual mode
vmap("<", "<gv")
vmap(">", ">gv")
vmap("<leader>k", ":'<,'>m '<-2<cr>gv") -- moving lines up (: instead of <cmd> because <cmd> does not leave visual mode)
vmap("<leader>j", ":'<,'>m '>+1<cr>gv") -- moving lines down (see above)
-- END visual mode

-- START insert mode
vim.cmd[[
function! CleverTab()                                                                           
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'                                         
        return "\<Tab>"                                                                           
    else                                                                                         
        return "\<C-N>"                                                                           
    endif                                                                                        
endfunction                                                                                     
inoremap <Tab> <C-R>=CleverTab()<CR>
inoremap <S-Tab> <C-P>
]]
-- END insert mode

-- START normalvisual mode
nvmap("<leader>r", "<cmd>make<cr>")
-- END normalvisual mode

-- START integrated terminal
local function term_toggle(close)
    close = close or false;
    local is_terminal = vim.bo.buftype == "terminal";
    if is_terminal then
        if close then
            vim.api.nvim_buf_delete(0, {force = true})
        else
            vim.cmd([[b #]])
        end
    else
        local buffers = vim.api.nvim_list_bufs();
        -- vim.print(buffers)
        for _, buf in ipairs(buffers) do
            if vim.bo[buf].buftype == "terminal" then
                vim.api.nvim_set_current_buf(buf);
                return
            end
        end
        vim.cmd[[term]]
    end
end

vim.keymap.set('n', "<leader>t", function () term_toggle(false) end)
vim.keymap.set('n', "<leader>T", function () term_toggle(true) end)

vim.keymap.set('t', "<Esc><Esc>", "<C-\\><C-n>") -- leave terminal insert with double esc
vim.keymap.set('t', "<S-Esc><S-Esc>", "<C-\\><C-n>") -- leave terminal insert with double esc
-- END integrated terminal
-- END using vim integrated stuff
