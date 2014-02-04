# 
PWD=`git rev-parse --show-toplevel`
cp ~/.vimrc ${PWD}/vimrc
mkdir -p ${PWD}/.vim/plugin
cp ~/.vim/plugin/csindent.vim ${PWD}/.vim/plugin
git commit -a
