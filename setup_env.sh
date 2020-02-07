#!/bin/bash
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


HOME_SOURCE_DIR="$ROOT_DIR"/home
PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
VIM_SOURCE_DIR="$ROOT_DIR"/vim


# Source functions
source "$HOME_SOURCE_DIR/_.functions"


replace_dotfiles() {
    for sourcefile in $(find "$HOME_SOURCE_DIR" -maxdepth 1 ! -path "$HOME_SOURCE_DIR"); do
        local destfile="$HOME/$(basename "$sourcefile" | sed 's/^_//')"

        echo "from $sourcefile to $destfile"
        backup_and_rm "$destfile"
        ln -s "$sourcefile" "$destfile"
    done
}


setup_ohmyzsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        remote_pipe "http://install.ohmyz.sh" /bin/sh
    else
        log_info "oh-my-zsh already installed, skipping..."
    fi
}


setup_vim() {
    local vimdir="$HOME/.vim"

    rm -rf "$vimdir"
    mkdir -p "$vimdir/plugged" "$vimdir/tmp"
    curl -fLo "$vimdir/autoload/plug.vim" --create-dirs "$PLUG_URL"

    for f in "$VIM_SOURCE_DIR"/*; do
        ln -s $f ~/.vim/$(basename $f)
    done

    VIM_FIRST_RUN=1 vim -E +silent +PlugInstall +qa
    VIM_FIRST_RUN=1 vim -E +silent '+CocInstall coc-python' '+CocInstall coc-json' '+CocInstall coc-tsserver' +qa
}


main() {
    # Setup oh-my-zsh before moving .zshrc
    setup_ohmyzsh
    replace_dotfiles

    # Setup vim after moving .vimrc
    setup_vim
}


main
