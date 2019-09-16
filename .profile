## This is the base profile runtime configuration. This script should be
## OS-Agnostic, and imported before the OS-specific profiles are

# source shared functions
source "${HOME}/.functions"


# Application Config
#~~~~~~~~~~~~~~~~~~~

setup_ssh() {
    local ssh_dir="${HOME}/.ssh"

    # Start SSH agent if not already started
    if [ -z ${SSH_AUTH_SOCK+x} ]; then
        echo 'setting SSH'
        silence ssh-agent
        # Add keys if SSH directory exists
    else
        echo 'SSH agent already set'
    fi

    if silence ls "${ssh_dir}"/*.pem; then
        ssh-add "${ssh_dir}"/*.pem
    fi
}

#Trackpad mappings
setup_mouse() {
    silence synclient PalmDetect=1
    silence synclient RBCornerButton=2
}


# Main Runner Functions
#~~~~~~~~~~~~~~~~~~~~~~

# Runs only for osx
run_mac() {
    # Homebrew
    path_append_front /usr/local/sbin
    path_append_front /usr/local/bin
    if [ -f /usr/libexec/java_home ]; then
        export JAVA_HOME=$(/usr/libexec/java_home -V 2> /dev/null)
        export JDK_HOME=$(/usr/libexec/java_home -V 2> /dev/null)
    fi
    # GNU Core utils
    if silence which brew; then
        path_append_front $(brew --prefix coreutils)/libexec/gnubin
    fi

    if [ -d /Library/TeX/texbin ]; then
        path_append_front /Library/TeX/texbin
    fi

    if silence which gcloud; then
        local sdk_dir="$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

        export PATH="$sdk_dir/bin:$PATH"
    fi

}

# Runs only for linux
run_linux() {
    setup_mouse
    alias get_battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | sed 's/ //g' | cut -d':' -f2"
    alias ack='ack-grep'
    if silence which java; then
        export JAVA_HOME=$(dirname $(readlink -f $(which java)))
        export JDK_HOME=$(dirname $(readlink -f $(which java)))
    fi
}

# Runs for all os types. Runs last
run_all() {
    setup_ssh

    export LS_OPTS="--color=auto --group-directories-first"

    alias g='git'
    alias gg='git grep'
    alias ggrep='git grep'
    alias gpy="grep --include='*.py'"
    alias ls="ls ${LS_OPTS}"
    alias ll="ls -Falh ${LS_OPTS}"
    alias l="ls -Flh ${LS_OPTS}"
    alias j="jobs"
    alias openports='res=$(sudo lsof -Pan -i tcp -i udp) && echo ${res} | head -n1 && echo ${res} | grep -i "listen"'
    alias pcat='pygmentize -O style=native -g'
    alias up="cd ~/repos/keep/saltmine-dev && vagrant up --no-provision && ssh outland"


    ## Customize Environment
    export CLICOLOR=1
    export EDITOR='vim'
    # no duplicate entries.
    export HISTCONTROL=ignoredups:erasedups
    # save a lot of history.
    export HISTSIZE=100000
    export HISTFILESIZE=100000

	# Less Colors for Man Pages
	export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
	export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
	export LESS_TERMCAP_me=$'\e[0m'           # end mode
	export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
	export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
	export LESS_TERMCAP_ue=$'\e[0m'           # end underline
	export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8

    export LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx"
    export PAGER='less'
    export PERL5LIB="${HOME}/perl5/lib/perl5"
    export PERL_CPANM_OPT="--local-lib=~/perl5"
    export TERM='xterm-256color'

    # Put private things in .local_profile
    if [ -f "${HOME}/.local_profile" ]; then
        echo "Sourcing local profile..."
        source "${HOME}/.local_profile"
    fi

    # Os-specific runners
    if [[ "${OSTYPE}" =~ "darwin" ]]; then
        run_mac
    elif [[ "${OSTYPE}" =~ "linux" ]]; then
        run_linux
    fi

    path_append_front ${HOME}/bin

    if silence which npm; then
        path_append_front $(npm get prefix)/bin
    fi

    # Ruby
    if [[ -s "${HOME}/.rvm/scripts/rvm" ]]; then
        path_append_front ${HOME}/.rvm/bin
        source "${HOME}/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
    fi

    if [ -d "$HOME/.local/bin" ]; then
        PATH="$HOME/.local/bin:$PATH"
    fi
}

# Main runner
run_all

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

gam() { "/Users/b/bin/gam/gam" "$@" ; }
eval "$(pyenv init -)"
