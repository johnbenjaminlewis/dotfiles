# Oh my zsh
export ZSH=$HOME/.oh-my-zsh
source ~/.functions


# Pycharm uses a really stripped down $PATH. Correct that _before_
# calling ohmyzsh plugins.
path_append_front /usr/local/bin
if silence which brew; then
    path_append_front $(brew --prefix coreutils)/libexec/gnubin:
fi


ZSH_CUSTOM="$HOME/.ben-zsh"
ZSH_THEME="ben"
COMPLETION_WAITING_DOTS="true"

plugins=(
    aws
    cabal
    celery
    cp
    cpanm
    django
    docker
    docker-compose
    fabric
    history-substring-search
    gem
    git
    git-alias
    git-fast
    git-extras
    gnu-utils
    golang
    grunt
    knife
    knife_ssh
    kubectl
    nmap
    node
    npm
    pip
    postgres
    python
    perl
    rails
    redis-cli
    rsync
    ruby
    rvm
    screen
    stack
    sudo
    supervisor
    systemd
    vagrant
    virtualenvwrapper
)

if [[ "${OSTYPE}" =~ "darwin" ]]; then
    plugins+=(
        brew
        brew-cask
        osx
    )
fi

if [[ "${OSTYPE}" =~ "linux" ]]; then
    plugins+=(
        command-not-found
        debian
        dircycle
        ubuntu
        systemd
    )
fi

source "${ZSH}/oh-my-zsh.sh"
bindkey \^U backward-kill-line


# User configuration
source "${HOME}/.profile"
