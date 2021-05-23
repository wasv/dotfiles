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

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
call plug#end()

let g:preview_markdown_parser = 'mdcat'
let g:preview_markdown_auto_update = 1

let g:rainbow_active = 1

let g:cmake_build_dir_location = 'build'

" Compe Config {{{
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
"}}}

"}}}

"{{{ Ranger Filetree
let g:ranger_replace_netrw = 1 
"}}}

" Display {{{
syntax on
colorscheme koehler
set nocompatible
filetype plugin on
set completeopt=menuone,noselect
 
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
noremap <C-S-V> i<C-R>+<Esc>

" Leader Key {{{
noremap <Leader>f :foldclose<CR>
noremap <Leader>t :Vexplore<CR>
" }}}
" }}}

" LSP {{{

lua << EOF
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Check if it's already defined for when reloading this file.
if not lspconfig.glslls then
  configs.glslls = {
    default_config = {
      cmd = {'glslls', '--stdin'};
      filetypes = {'glsl'};
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end

lspconfig.glslls.setup{}

local servers = { "rls", "clangd", "cmake", "pyls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach }
end
EOF

" }}}
" vim: foldmethod=marker
