[[ $- =~ i ]] || return


. ~/.bash_colors


function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
}


function parse_hg_branch {
    hg branch 2> /dev/null | sed -e "s/\(.*\)/[\1]/"
}


function __prompt_command {
    local EXIT="$?" # must do this first
    PS1="${IGreen}\u${Color_Off}@${BGreen}\h${Color_Off}  "
    PS1+="\w  ${Yellow}$(kubectl config current-context 2> /dev/null || echo "<null>")${Color_Off}  "

    # Is it bad?
    if [ $EXIT != 0 ]; then
        PS1+="${Red}$EXIT${Color_Off}"      # Add red if exit code non 0
    fi

    PS1+="\n → ${BIWhite}\$${Color_off} "
}


export PROMPT_COMMAND=__prompt_command


# Added automatically by dotfiles setup script
source ~/.profile

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

complete -C /usr/local/Cellar/terraform/0.11.7/bin/terraform terraform
