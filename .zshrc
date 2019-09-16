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
    pyenv
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


# Don't bitch if glob didn't match
setopt +o nomatch
source "${ZSH}/oh-my-zsh.sh"
bindkey \^U backward-kill-line


# User configuration
source "${HOME}/.profile"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/Cellar/terraform/0.11.7/bin/terraform terraform
unset COMPLETION_WAITING_DOTS
