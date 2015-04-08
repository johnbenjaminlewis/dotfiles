# vi: ft=sh


# Custom prompt, show git branch if in a repository
_git_prompt_info () {
    local _git_prefix="%{$fg[yellow]%}‹"
    local _git_suffix="›%{$reset_color%}"
    local ref
	if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
	    # Try symbolic branch name, if not get commit hash, if not, we're not in a git repo
		ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
		ref=$(command git rev-parse --short HEAD 2> /dev/null)  || \
		return 0

		echo "${_git_prefix}${ref#refs/heads/}${_git_suffix}"
	fi
}


left_prompt() {
    local host_name
    local current_dir='%{$terminfo[bold]$fg_bold[cyan]%}%~%{$reset_color%}'
    local git_branch='$(_git_prompt_info)'
    local user_name='%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}'

    # If in SSH session, color the host red, else color it green
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        host_name='%{$fg[red]%}%m%{$reset_color%}'
    else
        host_name='%{$fg_bold[green]%}%m%{$reset_color%}'
    fi

    echo -e "${user_name}@${host_name} ${current_dir} ${git_branch}\n→ %B$%b "
}


right_prompt() {
    local return_code='%(?..%{$fg[red]%}%?%{$reset_color%})'
    echo "${return_code}"
}


PROMPT=$(left_prompt)
RPS1=$(right_prompt)
