#!/bin/bash

mkdir -p ~/.vim
cp -r ./.vim/* ~/.vim
cp ./.vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
#vim +BundleInstall +qall
vim +PluginInstall +qall
