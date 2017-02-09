# Oh my zsh
export ZSH=$HOME/.oh-my-zsh

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
    ssh-agent
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
