local keys = require("keys.util")

keys.vmap("<", "<gv")  -- indenting out and keep selection
keys.vmap(">", ">gv")  -- indent and keep selection
keys.vmap("<leader>k", ":'<,'>m '<-2<cr>gv") -- moving lines up (: instead of <cmd> because <cmd> does not leave visual mode)
keys.vmap("<leader>j", ":'<,'>m '>+1<cr>gv") -- moving lines down (see above)
