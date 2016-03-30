" Basic settings
syntax on
color elflord
set expandtab
set ruler
set softtabstop=4
set number
set autoindent

" Plugin setup.
call plug#begin('~/.vim/plugged')
Plug 'artur-shaik/vim-javacomplete2'
Plug 'airblade/vim-rooter'
call plug#end()

" Enable spell checking on TeX and markdown files.
autocmd FileType tex,markdown :setlocal spell

" Recognize .md as markdown files.
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Enable javacomplete2 on .java files.
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" vim-rooter configuration.
let g:rooter_disable_map = 1
let g:rooter_change_directory_for_non_project_files = 'current'

" Custom commands.
command Build execute "!bash .build"
command Run   execute "!bash .build && bash .run"
