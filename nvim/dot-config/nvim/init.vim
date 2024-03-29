"{{{ Plug.vim Setup
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dir https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
"}}}

"{{{ Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'luochen1990/rainbow'
Plug 'airblade/vim-gitgutter'

Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'cdelledonne/vim-cmake'

Plug 'skanehira/preview-markdown.vim'

Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'

Plug 'https://gitlab.com/dbeniamine/todo.txt-vim'

runtime! plug.d/*.vim
call plug#end()

let g:preview_markdown_parser = 'mdcat'
let g:preview_markdown_auto_update = 1

let g:rainbow_active = 1

let g:cmake_build_dir_location = 'build'

let g:ranger_replace_netrw = 1 

let g:Todo_txt_prefix_creation_date=1
let g:TodoTxtUseAbbrevInsertMode=1
"}}}

" Display {{{
syntax on
colorscheme koehler
set nocompatible
filetype plugin on
set completeopt=menuone,noselect
 
" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'git', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineTruncatedFileName',
      \   'git': 'FugitiveStatusline'
      \ }
      \ }

function! LightlineTruncatedFileName()
    let l:filePath = expand('%:')
    if winwidth(0) > 120
        return l:filePath
    else
        return pathshorten(l:filePath)
    endif
endfunction
" }}}

" Wildmenu {{{
set wildmenu                " Autocomplete preview
set wildmode=longest:full   " Complete to longest common completion
" Ignore these patterns when globbing
set wildignore+=*.pyc,*.swp
set wildignore+=**/__pycache/**
" }}}

" Column Highlights {{{
set colorcolumn=80,100,120 " Reference line stopping points

" The default bright red was a bit too harsh for me
hi ColorColumn ctermbg=8 guibg=Gray
hi IncSearch ctermbg=10 ctermfg=5
hi Search ctermfg=254 ctermbg=12
hi DiffDelete ctermfg=8 ctermbg=6
hi SpellLocal ctermfg=13 ctermbg=14
" }}}

" Reduce redraws mid macro for preformance
set lazyredraw

" When a paragraph goes off the window, draw as much of it as possible
" Represents cut off lines with '@@@' on the last line of the screen
set display+=truncate

"{{{ Spaces by default not tabs
set noautoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
"}}}

" Break at whitespace only. Not in middle of word.
set wrap linebreak breakat&vim
" Show command as it is being typed
set showcmd
" Enable mouse support if available
set mouse=a
" Display Cursor location
set ruler
" Display line numbers
set number
" Don't show --INSERT--
set noshowmode
" Shorten Timeout
set ttimeoutlen=50
" Show status bar always
set laststatus=2
"}}}

" Searching {{{
" Don't highlight on search
set nohlsearch
" If possible, search while typing
if has('reltime')
  set incsearch
endif
" }}}

" Backups and Undo {{{
set backup
set backupdir=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/* " Don't backup private things
set directory=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Persist undo across save and reload
set undofile
set undodir=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Write to swapfile more frequently
set updatetime=500
" }}}

" Filetype autocmds {{{

" Makefiles - in makefiles, don't expand tabs to spaces
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
" Javascript, JSON, YAML - set 2 space tabs
autocmd FileType javascript,typescript,json,yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
" Spellcheck for text sort of files
autocmd FileType latex,tex,markdown,md,text setlocal spell
autocmd FileType todo setlocal nospell
autocmd filetype todo setlocal omnifunc=todo#Complete
autocmd filetype todo imap <buffer> + +<C-X><C-O>
autocmd filetype todo imap <buffer> @ @<C-X><C-O>


" Git Commit
autocmd FileType gitcommit setlocal spell colorcolumn=51,73
" Use Python recommended indetation style.
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
" Recognize .md as markdown files.
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Use modelines
set modeline
" }}} 

" Folding {{{
" Enable folding
augroup ft_folding
    autocmd!
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType c,cpp,rust setlocal foldmethod=syntax

    " Show folds on the left bar
    set foldcolumn=1
    set foldlevel=9
    set foldnestmax=9

    " autocmd BufWrite * mkview
    " autocmd BufRead * silent loadview

    set foldopen+=jump,insert
augroup END
" }}}

" Keybindings {{{

" Remap j/k to move accross virtual lines.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paste
inoremap <silent> <C-S-V>  <C-R>+
cnoremap <C-S-V> <C-R>+
"noremap <C-S-V> i<C-R>+<Esc>

" Leader Key {{{
autocmd FileType python nmap <buffer> <Leader>f :%!autopep8 -<CR>
autocmd FileType python vmap <buffer> <Leader>f :!autopep8 -<CR>
" }}}
" }}}

runtime! rc/*.vim

" vim: foldmethod=marker
