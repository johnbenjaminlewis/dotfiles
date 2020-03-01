# vim: filetype=sh
# Oh my zsh
export ZSH=~/.oh-my-zsh

source ~/.functions

# Pycharm uses a really stripped down $PATH. Correct that _before_
# calling ohmyzsh plugins.
path_append_front /usr/local/bin
# path_append_front /usr/local/opt/coreutils/libexec/gnubin:

ZSH_CUSTOM=~/.ben-zsh
ZSH_THEME="ben"

plugins=(
    docker
    docker-compose
    docker-machine
    git
    gnu-utils
    nmap
    node
    npm
    npx
    pip
    pipenv
    postgres
    pyenv
    python
    stack
    sudo
    terraform
)

if [[ "${OSTYPE}" =~ "darwin" ]]; then
    plugins+=(
        brew
        osx
    )
fi

if [[ "${OSTYPE}" =~ "linux" ]]; then
    plugins+=(
        debian
        dircycle
        systemd
        ubuntu
        ufw
    )
fi

setopt +o nomatch             # Don't bitch if glob didn't match
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.

source "$ZSH/oh-my-zsh.sh"
bindkey \^U backward-kill-line
bindkey \^B backward-word
bindkey \^F forward-word

# User configuration
source ~/.profile

unset COMPLETION_WAITING_DOTS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
