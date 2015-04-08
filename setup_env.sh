#!/bin/bash


FILE_NAMES=(
  .bashrc
  .bash_colors
  .ben-zsh
  .functions
  .gitconfig
  .profile
  .psqlrc
  .pylintrc
  .vimrc
  .vimrc
  .zshrc
)
VUNDLE_REPO="https://github.com/gmarik/Vundle.vim.git"
SOURCE_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# Source functions
source ${SOURCE_DIR}/.functions


replace_file() {
    local basename=$1
    local origin="$SOURCE_DIR/$basename"
    local filename="$HOME/$basename"
    local newname="$HOME/${basename}_bak"

    if [ -f "$filename" ] || [ -d "$filename" ]; then
        log_info "Backing up '$basename'..."
        mv "$filename" "$newname"
    elif [ -L "$filename" ]; then
        log_info "Removing symlink '$filename' -> '$(readlink -f \"$filename\")'"
        rm "$filename"
    fi
    ln -s "$origin" "$filename"
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
  local timeout=3

  mkdir -p $vimdir/tmp
  for dir in ${vimdirs[*]}; do
    if [ ! -d $vimdir/$dir ]; then
      mkdir -p $vimdir/$dir
    fi
  done
  silence git clone $VUNDLE_REPO $vimdir/bundle/vundle
  vim -E +Silent +BundleInstall +qa

  # Prompt user to compile you complete me
  echo "Compile YouCompleteMe? (Or wait $timeout seconds) [yN]"
  read -t $timeout  do_install
  if  [[ $do_install =~ ^[Yy]$ ]]; then
    $vimdir/bundle/YouCompleteMe/install.py --all
  fi
  touch ~/.localvimrc_persistent
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
