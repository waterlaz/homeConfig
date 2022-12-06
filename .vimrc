set tabstop=4
set shiftwidth=4
set expandtab
syntax enable
set textwidth=0
set wrapmargin=0
set formatoptions-=t
set smartindent
autocmd BufWritePre * %s/\s\+$//e
