local keys = require("keys.util")

keys.nmap("<leader>o", "<cmd>update<cr><cmd>source ~/.config/nvim/init.lua<cr>") -- source config
keys.nmap("<esc>", "<cmd>nohlsearch<CR>")                -- remove search highlighting
keys.nmap("<leader>v", "ggVG")                           -- select whole file in visual line
keys.nmap("<leader>k", "<cmd>m .-2<cr>")                 -- move current line up (by one line)
keys.nmap("<leader>j", "<cmd>m .+1<cr>")                 -- move current line down (by one line)
keys.nmap("x", "\"_x")  -- don't save the character on the clipboard
keys.nmap("X", "\"_X")  -- don't save the character on the clipboard
keys.nmap("<leader>x", "xp")  -- swap the right character with the character under the cursor
keys.nmap("<leader>X", "Xp")  -- swap the left character with the character under the cursor
keys.nmap("<leader>be", "<cmd>e#<cr>")  -- go to previous buffer (if it had a name)
keys.nmap("<leader>bs", "<cmd>vertical sf #<cr>")  -- split current buffer with previous vertically
keys.nmap("<leader>bo", "<cmd>%bd|e#|'\"<cr>")  -- close every other buffer than the current
keys.nmap("<leader>ww", "<cmd>vsplit<cr>")  -- split current buffer into two windows. go to the new window
keys.nmap("<leader>wo", "<cmd>only<cr>zz")  -- show only the buffer of the current window (closes all other windows)
keys.nmap("<leader>wb", "<cmd>ball<cr><C-w>=")  -- show every opened buffer

-- START center movement
-- below commands force the cursor to stay on the middle of the screen
keys.center_movement("*")
keys.center_movement("#")
keys.center_movement("n")
keys.center_movement("N")
keys.center_movement("G")
keys.center_movement("<C-u>")
keys.center_movement("<C-d>")
keys.center_movement("<C-b>")
keys.center_movement("<C-f>")
-- END center movement
