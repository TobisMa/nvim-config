-- use ftplugin folder for language specific colors
vim.cmd[[
colorscheme vague
hi Search ctermfg=0 ctermbg=11 guifg=#cdcdcd guibg=#405065

hi NonText guifg=red
hi Whitespace guifg=#a5a5a5
"hi PreInsert cterm=bold
hi ColorColumn ctermbg=black

hi ComplMatchIns gui=NONE guifg=#777777
hi LspInlayHint gui=italic guifg=#777777
]]


