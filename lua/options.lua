vim.opt.title = true
vim.opt.belloff = "all"
vim.opt.mouse = "a"

vim.g.mapleader = ' '
vim.g.localleader = ' '
vim.opt.timeoutlen = 500

vim.opt.wrap = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.formatoptions = "tcrlvj1q/n"

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = " >> "
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', leadmultispace= "│   "}
vim.opt.nrformats = "bin,hex,octal,alpha"
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.colorcolumn = "100"
vim.opt.textwidth = 100
vim.opt.virtualedit = "block"

vim.opt.number = true
vim.opt.relativenumber = true
vim.o.scrolloff = 5

vim.o.showtabline = 2
vim.o.laststatus = 2
vim.opt.winborder = "rounded"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.incsearch = true

vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- look help of ins-completion for ctrl+x submodes; ctrl+e for stopping completion
vim.opt.completeopt = "fuzzy,menu,menuone,noselect,popup"
vim.opt.completeitemalign= "abbr,kind,menu"
vim.opt.syntax = "on"
vim.cmd[[filetype plugin on]]
vim.opt.pumheight = 20


vim.opt.mps:append { '<:>', '=:;', '⟨:⟩', '⌈:⌉', '⌊:⌋', '»:«', '›:‹', '„:“', '„:”', '‚:‘', '‚:’'}

vim.opt.spelllang = "en,de"
vim.opt.path:append "**"
vim.opt.wildignore = {
    "__pycache__",
    ".git",
    "*.pyc",
    "*.exe",
    "*.so",
    "*.a",
    "*.class",
    "*.o",
    "*.bak",
}

vim.schedule(function ()
    vim.opt.clipboard = 'unnamedplus'
end)


