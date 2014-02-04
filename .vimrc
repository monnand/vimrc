" This vimrc is opmtimized for Go programming language.
" To use this configuration, make sure you have
" installed Go ( http://golang.org ). Once you installed
" Go environment, use the following commands to install
" other tools:
"
"   go get github.com/bradfitz/goimports
"   go get code.google.com/p/rog-go/exp/cmd/godef
"   go get github.com/nsf/gocode
"   go get github.com/jstemmer/gotags
"   go get github.com/golang/lint/golint
"
set nocompatible

set background=dark

" Set the leader
let mapleader = ','

" Setup Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" NERDTree
Bundle 'scrooloose/nerdtree'
nnoremap <leader>ne :NERDTree<CR>
Bundle 'spf13/vim-colors'

" fugitive.vim: A Git wrapper so awesome, it should be illegal.
Bundle 'tpope/vim-fugitive'

" YouCompleteMe
" https://github.com/Valloric/YouCompleteMe
"
" To use this on Ubuntu, we need to update vim to the latest version.
" Use this PPA: https://launchpad.net/~nmi/+archive/vim-snapshots
"
" sudo add-apt-repository ppa:nmi/vim-snapshots
" sudo apt-get update
" sudo apt-get dist-upgrade
"
" Then compile YCM:
"
" sudo apt-get install build-essential cmake
" sudo apt-get install python-dev
"
" cd ~/.vim/bundle/YouCompleteMe
" ./install.sh --clang-completer
Bundle 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

Bundle 'scrooloose/syntastic'

" Easy motion. A tutorial could be found here:
" http://net.tutsplus.com/tutorials/other/vim-essential-plugin-easymotion/
" Note: The default leader has been changed to <Leader><Leader>
" Type ,,w to see the magic happens.
Bundle 'Lokaltog/vim-easymotion'

" protobuf
Bundle 'uarun/vim-protobuf'

" Go
" We are using cespare's modification,
" which uses bradfitz's goimports instead of gofmt.
"
" With goimports, you can add missing imports automatically.
"
" To install goimport:
"   go get github.com/bradfitz/goimports
Bundle 'cespare/vim-golang'

" To install godef:
"   go get code.google.com/p/rog-go/exp/cmd/godef
Bundle 'dgryski/vim-godef'

" To install gocode:
"   go get github.com/nsf/gocode
"Bundle 'undx/vim-gocode'
Bundle 'Blackrush/vim-gocode'

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

" ---------------- Some general hack --------------
filetype plugin indent on
syntax on

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Easily change my vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Easily quote something
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>l

" do not use <esc>
inoremap jk <esc>
vnoremap jk <esc>

" Tips:
" - normal mode, :Vex[plore] :Ex[plore] :Sex[plore]

" movement mapping. See LVSH (Learn VIM Script the Hardway) 15.1
onoremap p i(

"
" Set status line
if has('statusline')
	set laststatus=2

	" Broken down into easily includeable segments
	set statusline=%<%f\ " Filename
	set statusline+=%w%h%m%r " Options
	set statusline+=\ [%{&ff}/%Y] " filetype
	" csindent.vim
	" http://www.vim.org/scripts/script.php?script_id=2633
	set statusline+=\ [%{CodingStyleIndent()}] " csindent
	set statusline+=\ [%{getcwd()}] " current dir
	set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

set nu			" Line number
set foldenable		" auto fold code
set hlsearch		" highlite search
set showmatch		" show matching {}/()


" set cursor line and column
set cursorline
set cursorcolumn


set pastetoggle=<F12>	" pastetoggle

" Yank from the cursor to the end of the line
nnoremap Y y$

" -------------------------------------------


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

" Let's gofmt it before saving it
autocmd BufWritePre *.go :Fmt

" TeX file should be aligned
autocmd BufWritePre *.tex :set tw=80

" golint
" To install golint:
"   go get github.com/golang/lint/golint
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

" tags
" C-\ - Open the definition in a new tab
" A-] - Open the definition in a vertical split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
