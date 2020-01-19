# vim: filetype=sh

# Is this an interactive shell?
[[ $- =~ i ]] || return

source ~/.colors

function parse_git_branch() {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
}

function parse_hg_branch() {
    hg branch 2>/dev/null | sed -e "s/\(.*\)/[\1]/"
}

function __prompt_command() {
    local EXIT="$?" # must do this first
    PS1="${IGreen}\u${Color_Off}@${BGreen}\h${Color_Off}  "
    PS1+="\w  ${Yellow}$(kubectl config current-context 2>/dev/null || echo "<null>")${Color_Off}  "

    # Is it bad?
    if [ $EXIT != 0 ]; then
        PS1+="${Red}$EXIT${Color_Off}" # Add red if exit code non 0
    fi

    PS1+="\n → ${BIWhite}\$${Color_off} "
    return "$EXIT"
}

export HISTCONTROL=ignoreboth:erasedups
export PROMPT_COMMAND=__prompt_command

# Added automatically by dotfiles setup script
source ~/.profile

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
