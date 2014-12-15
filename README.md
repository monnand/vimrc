vimrc
=====

My vimrc. Designed to work better with [Go].

It uses ['fatih/vim-go'](http://github.com/fatih/vim-go) to work with [Go]. To
better faciliate editing [Go] source code,
[YCM](http://github.com/Valloric/YouCompleteMe) and
[utilsnips](http://github.com/SirVer/ultisnips) are also used.

Follow the following steps to use this config:

- Setup [Go] development environment. Set GOPATH
- run ``./deploy.sh``.
- ``sudo apt-get install build-essential cmake``
- ``sudo apt-get install python-dev``
- ``sudo apt-get install libclang-dev``
- ``cd ~/.vim/bundle/YouCompleteMe``
- ``./install.sh --clang-completer``


[Go]: http://golang.org
