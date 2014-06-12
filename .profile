## This is the base profile runtime configuration. This script should be
## OS-Agnostic, and imported before the OS-specific profiles are

# Application Config
#~~~~~~~~~~~~~~~~~~~

silence() { "$@" 2> /dev/null > /dev/null }

setup_ssh() {
    SSH_DIR="$HOME/.ssh"
    # Start SSH agent if not already started
    if ! silence pgrep 'ssh-agent'; then 
        silence ssh-agent
    fi

    # Add keys if SSH directory exists
    if [ -d "$SSH_DIR" ]; then
        find "$SSH_DIR" -name '*\.pem' | xargs ssh-add 2> /dev/null > /dev/null
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
    echo "mac"
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"
}

# Runs only for linux
run_linux() {
    echo "linux"
    setup_mouse
}

# Runs for all os types. Runs last
run_all() {
    echo "all"
    LS_OPTS="--color=auto --group-directories-first"

    alias ls="ls $LS_OPTS"
    alias ll="ls -Falh $LS_OPTS"
    alias l="ls -Flh $LS_OPTS"

    ## Customize Environment
    export CLICOLOR=1
    export EDITOR='vim'
    export LANG='en_US.UTF-8'
    export LC_ALL='en_US.UTF-8'
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
    export PAGER='less'
    export PATH="$HOME/bin:$PATH"
    export TERM='xterm-256color'
}

# Main runner
if [[ "$OSTYPE" == "darwin"* ]]; then
    run_mac
elif [ "$OSTYPE" == "linux-gnu"; then
    run_linux
fi

run_all
