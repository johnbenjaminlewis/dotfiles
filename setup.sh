#!/bin/bash

FILE_NAMES=(
  .gitconfig
  .profile
  .pylintrc
  .vimrc
  .vimrc
  .zshrc
)
VUNDLE_REPO="https://github.com/gmarik/Vundle.vim.git"
SOURCE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


silence() { "$@" 2> /dev/null > /dev/null; }


replace_file() {
  filename=$1
  newname="${filename}_bak"
  mv $HOME/$filename $HOME/$newname
  ln -s $SOURCE_DIR/$filename $HOME/$filename
}


process_files() {
  for f in ${FILE_NAMES[*]}; do
    replace_file $f
  done
}


setup_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    curl -L http://install.ohmyz.sh | sh
  else
    echo "oh-my-zsh already installed, skipping..."
  fi
}


setup_vim() {
  vimdir="$HOME/.vim"
  mkdir -p $vimdir/tmp
  vimdirs=(tmp bundle)
  for dir in ${vimdirs[*]}; do
    if [ ! -d $vimdir/$dir ]; then
      mkdir -p $vimdir/$dir
    fi
  done
  silence git clone $VUNDLE_REPO $vimdir/bundle/vundle
  vim +Silent +BundleInstall +qa
  #$vimdir/bundle/YouCompleteMe/install.sh --clang-completer
}


main() {
  . .profile

  # Setup oh-my-zsh before moving .zshrc
  setup_zsh
  process_files

  # Setup vim after moving .vimrc
  setup_vim
}


main
