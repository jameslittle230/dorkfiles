" use vim settings, rather then vi settings (much better!).
" this must be first, because it changes other options as a side effect.
set nocompatible

" =============== character fixes ====================

scriptencoding utf-8
set encoding=utf-8

" ================ general config ====================

set backspace=indent,eol,start  "allow backspace in insert mode
set history=1000                "store lots of :cmdline history
set showcmd                     "show incomplete cmds down the bottom
set showmode                    "show current mode down the bottom
set gcr=a:blinkon0              "disable cursor blink
set visualbell                  "no sounds
set autoread                    "reload files changed outside vim
set ruler                       "show ruler
set undolevels=1000             "undo levels
set laststatus=2                "fix status bar

"turn on syntax highlighting
syntax on

" highlight funky characters and whatnot
set list
set listchars=tab:▸\ ,trail:ـ,extends:➧,eol:¬

" Put contents of unnamed register in OS X clipboard
set clipboard=unnamed

" remap ESC to jk
inoremap jk <esc>

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.

if has('persistent_undo')
  "silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set wrap
set linebreak    " Wrap lines at convenient points

" =============== Status Line =====================

set statusline=
set statusline+=%f
set statusline+=%m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+="\ "
hi StatusLine ctermfg=208 ctermbg=234
hi StatusLineNC ctermfg=234 ctermbg=254
autocmd! InsertEnter * hi StatusLine ctermfg=220 ctermbg=234
autocmd! InsertLeave * hi StatusLine ctermfg=208 ctermbg=234

" =============== Other UI =====================

" Set line numbers
set relativenumber number
highlight LineNr ctermfg=238 "line numbers are super dark gray

" Color for the tildes after the end of the buffer
hi EndOfBuffer ctermfg=238

hi VertSplit ctermbg=0 ctermfg=234

" Tab bar colors
hi TabLineFill ctermfg=0
hi TabLine ctermbg=0
hi TabLine ctermfg=254
hi TabLineSel ctermfg=208

let mapleader=","
let g:mapleader=","

" Pressing ,ev should open my vimrc for editing in a new tab.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

" Scroll at seven lines of text from the bottom
set so=7

" Show matching brackets when the cursor is over them
set showmatch
set mat=2

" Highlight any characters that go over 80 columns
highlight ColorColumn ctermbg=red ctermfg=white
call matchadd('ColorColumn', '\%81v', 100)

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Special stuff for git commit editing
autocmd FileType gitcommit highlight ColorColumn ctermbg=238
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=73
autocmd FileType gitcommit set colorcolumn+=51

" Pressing ,<space> should un-highlight my most recent search
nmap <Leader><space> :nohlsearch <CR>

" Other search options to make it more
set hlsearch
set ignorecase
set smartcase
set incsearch

" Let j and k work over long, wrapped lines of text (doesn't really do
" anything if set wrap isn't on)
map j gj
map k gk

" Get rid of all bells because silence > bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Remove trailing whitespace on save
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Automatically toggle paste if we're pasting from the clipboard
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

" remap : to ;
nnoremap ; :

" background out of insert mode
inoremap <C-Z> <Esc><C-Z>

" ================ Plugins ==========================

call plug#begin('~/.local/nvim/plugins')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'          " useful Lua functions, e.g. like boost

Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'toyamarinyon/vim-swift'
Plug 'preservim/nerdtree'
Plug 'AndrewRadev/splitjoin.vim'      " split/join single line/multiline


" LSP
Plug 'neovim/nvim-lspconfig'             " out of the box LSP configs for common langs
Plug 'glepnir/lspsaga.nvim'              " code action plugin
Plug 'nvim-lua/lsp-status.nvim'          " provides statusline information for LSP
Plug 'hrsh7th/nvim-compe'                " completion engine
Plug 'onsails/lspkind-nvim'              " add vscode-style icons to completion menu
Plug 'nathunsmitty/nvim-ale-diagnostic'  " route lsp diagnostics to ALE
Plug 'ray-x/lsp_signature.nvim'          " floating signature 'as you type'
Plug 'dense-analysis/ale'

Plug 'npxbr/glow.nvim', {'do': ':GlowInstall'}  " markdown preview with :Glow

" Theming
Plug 'chrisbra/Colorizer'            " show hex colors in CSS/HTML files
Plug 'RRethy/vim-illuminate'         " highlight duplicate words
Plug 'drzel/vim-line-no-indicator'   " nice scroll indicator

" Version control
Plug 'rhysd/git-messenger.vim'  " show commit popup with <leader>gm
Plug 'tpope/vim-fugitive'       " the git plugin
Plug 'airblade/vim-gitgutter'   " show changed line marks in gutter
Plug 'tpope/vim-rhubarb'        " enable GHE/Github links with :Gbrowse
Plug 'TimUntersberger/neogit'
call plug#end()

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

