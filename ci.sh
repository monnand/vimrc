# 
PWD=`git rev-parse --show-toplevel`
cp ~/.vimrc ${PWD}/.vimrc
mkdir -p ${PWD}/.vim/plugin
mkdir -p ${PWD}/.vim/csindent/cpp
cp ~/.vim/plugin/csindent.vim ${PWD}/.vim/plugin/csindent.vim
cp ~/.vim/csindent/cpp/google.vim ${PWD}/.vim/csindent/cpp/google.vim
cp ~/.vim_csindent.ini ${PWD}/.vim_csindent.ini
git commit -a
