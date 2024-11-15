-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.g.netrw_winsize = 20
-- vim.g.netrw_banner = 0
-- vim.g.netrw_browse_split = 4
-- vim.g.netrw_altv = 0
-- vim.g.netrw_liststyle = 3
-- -- vim.g.netrw_keepdir = 0
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()
-- vim.g.netrw_hide = 0  -- shows all files (1 for only non-hidden; only hidden with 2)
-- vim.cmd("hi! link netrwMarkFile Search")


-- vim.g.netrw_ftp_list_cmd    = "ls -lF"
-- vim.g.netrw_ftp_timelist_cmd= "ls -tlF"
-- vim.g.netrw_ftp_sizelist_cmd= "ls -slF"

vim.opt.path:append "**"
vim.opt.wildignore = {"__pycache__", "*pyc", "*.exe", "*.so", "*.a", "*.class", "*.o", "*.bak", ".git"}
vim.opt.complete:append "i"
vim.opt.complete:append "kspell"
vim.opt.termguicolors = true
vim.opt.linebreak = true
vim.opt.title = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 500
vim.opt.timeoutlen = 400
vim.opt.breakindent = true

vim.o.wildmenu = true
vim.o.mouse = "a"
vim.opt.showmode = false
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.belloff = "all"

vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

vim.o.termguicolors = true
vim.o.completeopt = "menuone,menu,preview,noinsert"
vim.o.wrap = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.o.lazyredraw = true
vim.opt.colorcolumn = "100"

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.nrformats = "bin,hex,octal,alpha"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.o.showtabline = 2
vim.o.laststatus = 2

vim.o.langmap = "Ä},ä],Ü{,ü[,ö@"
-- vim.o.langremap = true
