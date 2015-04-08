# Oh my zsh
export ZSH=$HOME/.oh-my-zsh

ZSH_CUSTOM="$HOME/.ben-zsh"
ZSH_THEME="ben"
COMPLETION_WAITING_DOTS="true"

plugins=(
    cabal
    celery
    cpanm
    django
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
    nmap
    node
    npm
    pip
    postgres
    python
    perl
    rails
    rvm
    rsync
    ruby
    screen
    sudo
    supervisor
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
        docker
        ubuntu
    )
fi
bindkey \^U backward-kill-line

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source "${ZSH}/oh-my-zsh.sh"


# User configuration
source "${HOME}/.profile"
