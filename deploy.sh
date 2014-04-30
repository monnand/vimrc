#!/bin/bash

mkdir -p ~/.vim
cp -r ./.vim/* ~/.vim
cp ./.vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
