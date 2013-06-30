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

" To install gocode:
"   go get github.com/nsf/gocode
Bundle 'undx/vim-gocode'

" Markdown
Bundle 'monnand/vim-markdown'

" HTML
Bundle 'mattn/zencoding-vim'

" Tagbar
Bundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" .po file
Bundle 'po.vim'

" color scheme
Bundle 'molokai'

" erlang
Bundle 'jimenezrick/vimerl'

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

" Go tags
" To install gotags:
"     go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Translator information
let g:po_translator = "Nan Deng <monnand@gmail.com>"
let g:po_lang_team = "Chinese (Simplified)"

" Easily change my vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Easily quote something
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>l

" do not use <esc>
inoremap jk <esc>
vnoremap jk <esc>

" Let's gofmt it before saving it
autocmd BufWritePre *.go :Fmt

" golint
" To install golint:
"   go get github.com/golang/lint/golint
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim


" Tips:
" - normal mode, :Vex[plore] :Ex[plore] :Sex[plore]

