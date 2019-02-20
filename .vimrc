" Packages managed with vim-plug; run :PlugInstall to install packages and get
" Vim nicely set up
call plug#begin()
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'toyamarinyon/vim-swift'
call plug#end()

" Pressing ,ev should open my vimrc for editing in a new tab.
"<ctrl>-y to expand the emmet statement
",c<space> toggles the commented-ness of the current line

" Status line content
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

" Show status line
set laststatus=2

" Show partial command in status line
set showcmd

" Status line colors
hi StatusLine ctermfg=208 ctermbg=234
hi StatusLineNC ctermfg=234 ctermbg=254

autocmd! InsertEnter * hi StatusLine ctermfg=220 ctermbg=234
autocmd! InsertLeave * hi StatusLine ctermfg=208 ctermbg=234

" Backspace should work like other programs
set backspace=indent,eol,start

" Set line numbers
set relativenumber
set number
highlight LineNr ctermfg=238 "line numbers are super dark gray

" Color for the tildes after the end of the buffer
hi EndOfBuffer ctermfg=238

hi VertSplit ctermbg=0 ctermfg=234

" Tab bar colors
hi TabLineFill ctermfg=0
hi TabLine ctermbg=0
hi TabLine ctermfg=254
hi TabLineSel ctermfg=208

" Set the leader key to comma instead of backslash
let mapleader = ","

" Whenever I write to my vimrc, I want to source it as well to instantly see
" what I've done
augroup myvimrchooks
	au!
	autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

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

" Auto indent, smart indent. I've commented out wrapping text because I'm not
" sure if I want text to wrap or not. We'll see.
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set wrap
set linebreak

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

" Pressing jk in rapid succession takes me out of insert mode. This is the
" most helpful vim thing I've ever done.
imap jk <esc>

" Pressing pp in rapid succession should toggle paste
nnoremap pp :pastetoggle<CR>

" Let j and k work over long, wrapped lines of text (doesn't really do
" anything if set wrap isn't on)
map j gj
map k gk

" Remap tab and split commands
nnoremap <Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
nnoremap <Bar> :vsplit<CR>
nnoremap _ :split<CR>
nnoremap J <C-W>j
nnoremap K <C-W>k
nnoremap H <C-W>h
nnoremap L <C-W>l

set splitbelow
set splitright

" Get rid of all bells because silence > bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Remove trailing whitespace on save
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Ctrl-P mappings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" https://github.com/ctrlpvim/ctrlp.vim#basic-options
let g:ctrlp_working_path_mode = 'ra'

" Open NERDTree automatically if you start up with $ vim
" in a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
