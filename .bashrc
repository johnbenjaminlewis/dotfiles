[[ $- =~ i ]] || return


. ~/.profile
. ~/.bash_colors


function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
}


function parse_hg_branch {
    hg branch 2> /dev/null | sed -e "s/\(.*\)/[\1]/"
}


function __prompt_command {
    local EXIT="$?" # must do this first
    PS1="${BBlue}\u${Color_Off}@"
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        PS1+="${BRed}\h  "
    else
        PS1+="${BGreen}\h  "
    fi
    PS1+="${BYellow}\w  ${Yellow}$(parse_git_branch)$(parse_hg_branch)${Color_Off}  "

    # Is it bad?
    if [ $EXIT != 0 ]; then
        PS1+="${Red}→ $EXIT${Color_Off}"      # Add red if exit code non 0
    fi

    PS1+="\n$ "
}


export PROMPT_COMMAND=__prompt_command

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
