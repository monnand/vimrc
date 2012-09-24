set nocompatible

set background=dark

" Setup Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" General
Bundle 'scrooloose/nerdtree'
Bundle 'spf13/vim-colors'

" Go
Bundle 'monnand/vim-golang'
Bundle 'undx/vim-gocode'

" Markdown
Bundle 'monnand/vim-markdown'

" HTML
Bundle 'mattn/zencoding-vim'

filetype plugin indent on
syntax on

" Set status line
if has('statusline')
	set laststatus=2

	" Broken down into easily includeable segments
	set statusline=%<%f\ " Filename
	set statusline+=%w%h%m%r " Options
	set statusline+=\ [%{&ff}/%Y] " filetype
	set statusline+=\ [%{getcwd()}] " current dir
	set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

set nu			" Line number
set foldenable		" auto fold code
set hlsearch		" highlite search
set showmatch		" show matching {}/()

set pastetoggle=<F12>	" pastetoggle

" Set the leader
let mapleader = ','

" Yank from the cursor to the end of the line
nnoremap Y y$

" Python indent
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
