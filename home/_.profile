# vim: filetype=sh
## This is the base profile runtime configuration. This script should be
## OS-Agnostic, and imported before the OS-specific profiles are
# source shared functions
source ~/.colors
source ~/.functions

# Application Config
#~~~~~~~~~~~~~~~~~~~

#Trackpad mappings
setup_mouse() {
    silence synclient PalmDetect=1
    silence synclient RBCornerButton=2
}

# Main Runner Functions
#~~~~~~~~~~~~~~~~~~~~~~
_add_brew_dir() {
    local package=$1
    local subdir=$2
    if local prefix="$(brew --prefix "$package" 2>/dev/null)"; then
        path_append_front "$prefix/$subdir"
    fi
}

# Runs only for osx
run_mac() {
    # Homebrew
    path_append_front /usr/local/sbin
    path_append_front /usr/local/bin

    # GNU Core utils
    if silence which brew; then
        _add_brew_dir awk /bin
        # Bin utils breaks pyenv if it's put in the path
        # _add_brew_dir binutils /bin
        _add_brew_dir coreutils /libexec/gnubin
        _add_brew_dir findutils /libexec/gnubin
        _add_brew_dir gnu-sed /bin
        _add_brew_dir grep /libexec/gnubin
        _add_brew_dir lsof /bin
    fi

    path_append_front /Library/TeX/texbin
    path_append_front "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"

}

# Runs only for linux
run_linux() {
    setup_mouse
    alias get_battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | sed 's/ //g' | cut -d':' -f2"
    alias ack='ack-grep'
}

# Runs for all os types. Runs last
run_all() {
    source ~/.ssh-agent

    export LS_OPTS="--color=auto --group-directories-first"

    alias ls="ls $LS_OPTS"
    alias ll="ls -Falh $LS_OPTS"
    alias l="ls -Flh $LS_OPTS"
    alias j="jobs"
    alias openports='res=$(sudo lsof -Pan -i tcp -i udp) && echo $res | head -n1 && echo $res | grep -i "listen"'

    ## Customize Environment
    export CLICOLOR=1
    export EDITOR='vim'
    # no duplicate entries.
    export HISTCONTROL=ignoredups:erasedups
    # save a lot of history.
    export HISTSIZE=1000000
    export HISTFILESIZE=1000000

    export LESS="IFRS"
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
    export PYTHON_CONFIGURE_OPTS='--enable-framework'
    export TERM='xterm-256color'

    # Put private things in .local_profile
    if [[ -f ~/.local_profile ]]; then
        echo "Sourcing local profile..."
        source ~/.local_profile
    fi

    # Os-specific runners
    if [[ "$OSTYPE" =~ "darwin" ]]; then
        run_mac
    elif [[ "$OSTYPE" =~ "linux" ]]; then
        run_linux
    fi

    eval "$(pyenv init -)"
}

# Main runner
run_all
