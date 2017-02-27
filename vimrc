" Basic settings
syntax on
color elflord

" Spaces, not tabs
set noautoindent
set expandtab
set shiftwidth=4
set softtabstop=4

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

" Plugin setup.
call plug#begin('~/.vim/plugged')
" Plug 'artur-shaik/vim-javacomplete2'
Plug 'airblade/vim-rooter'
Plug 'scrooloose/syntastic'
" Plug 'vim-scripts/asmM6502.vim'
Plug 'airblade/vim-gitgutter'
" Plug 'Shirk/vim-gas'
" Plug 'davidhalter/jedi-vim'
Plug 'vitalk/vim-simple-todo'
" Plug 'vim-scripts/Smart-Tabs'
" Plug 'vim-airline/vim-airline'
Plug 'bronson/vim-trailing-whitespace'
call plug#end()

" Enable spell checking on TeX and markdown files.
"autocmd FileType tex,markdown setlocal spell

" Use Python recommended indetation style.
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" Recognize .md as markdown files.
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Enable javacomplete2 on .java files.
"autocmd FileType java setlocal omnifunc=javacomplete#Complete

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
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [],'passive_filetypes': ['asm'] }
let g:syntastic_vhdl_ghdl_args = '--ieee=synopsys'

" ASM Setup
let g:asmsyntax = 'gas'

" airline config
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#syntastic#get_warnings = 1
" set laststatus=2
" set noshowmode

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
