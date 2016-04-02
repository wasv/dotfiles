" Basic settings
syntax on
color elflord
set expandtab
set ruler
set softtabstop=4
set number

" Plugin setup.
call plug#begin('~/.vim/plugged')
Plug 'artur-shaik/vim-javacomplete2'
Plug 'airblade/vim-rooter'
Plug 'scrooloose/syntastic'
" Plug 'vim-airline/vim-airline'
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

" syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_javac_classpath = './src'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" airline config
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#syntastic#get_warnings = 1
" set laststatus=2
" set noshowmode

" Custom commands.
command Build execute "!bash .build"
command Run   execute "!bash .build && bash .run"

" Key mappings
nmap <Tab> :bn!<CR>
