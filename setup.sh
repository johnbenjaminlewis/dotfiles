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


silence() {
  "$@" 2> /dev/null > /dev/null;
}


log_info() {
  echo "INFO: $@" >&2
}


replace_file() {
  local filename=$1
  if [ -f "$HOME/filename" ]; then
    log_info "Backing up '$filename'..."
    local newname="${filename}_bak"
    mv $HOME/$filename $HOME/$newname
  elif [ -L "$HOME/$filename" ]; then
    log_info "Removing symlink '$HOME/$filename' -> '$(readlink -f $HOME/$filename)'"
    rm "$HOME/$filename"
  fi
  ln -s $SOURCE_DIR/$filename $HOME/$filename
}
 

process_files() {
  for f in ${FILE_NAMES[*]}; do
    replace_file $f
  done
}


setup_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
   local install_script=$(mktemp)
   # Don't pipe directly to sh!
   curl -L http://install.ohmyz.sh > $install_script && /bin/sh $install_script \
     || log_info "Oh my zsh failed to download..."
  else
    log_info "oh-my-zsh already installed, skipping..."
  fi
}


setup_bash() {
  # Keep existing .bashrc but make sure it sources ~/.profile
  local profile_file="$HOME/.profile"
  local bashrc_file="$HOME/.bashrc"
  if ! silence grep -P '\..*?\.profile$' "$bashrc_file" && \
     ! silence grep -P 'source.*?\.profile$' "$bashrc_file"; then
    cat << EOF >> "$bashrc_file"

# Added automatically by dotfiles setup script
source ~/.profile
EOF
  fi
}


setup_vim() {
  local vimdir="$HOME/.vim"
  local vimsubdirs=(tmp bundle)

  mkdir -p $vimdir/tmp
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
  setup_bash
  process_files

  # Setup vim after moving .vimrc
  setup_vim
}


main
