" Basic settings
syntax on
color elflord

" Spaces, not tabs
set noautoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set showcmd
set mouse=n
set ruler
set number
set updatetime=500
set backspace=indent,start,eol
set modeline

" Don't highlight on search
set nohlsearch

" Break at whitespace only. Not in middle of word.
set nolist wrap linebreak breakat&vim

" Enable spell checking on TeX and markdown files.
"autocmd FileType tex,markdown setlocal spell

" Use Python recommended indetation style.
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" Recognize .md as markdown files.
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Custom commands.
command Build execute "!bash .build"
command Run   execute "!bash .build && bash .run"

" Remap j/k to move accross virtual lines.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Key mappings
set timeoutlen=500
let mapleader="\<C-Space>"
" nmap <Tab> :bn!<CR>

" Printing
set printheader=%{strftime(\"%c\",getftime(expand(\"%%\")))}%=%t
set popt=syntax:n,bottom:36pt,top:36pt,right:36pt,left:36pt,number:y,paper:letter
set printexpr=PrintFile(v:fname_in)
function PrintFile(fname)
    execute '!lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice) . ' ' . a:fname
    return v:shell_error
endfunc
