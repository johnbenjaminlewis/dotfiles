LS_OPTS="--color=auto --group-directories-first"
alias ll="ls -Falh $LS_OPTS"
alias l="ls -Flh $LS_OPTS"

if ! pgrep -i 'ssh-agent' &> /dev/null; then 
    ssh-agent 2> /dev/null > /dev/null
fi
ssh-add ~/.ssh/*.pem 2> /dev/null > /dev/null

## Mouse/Touchpad
synclient PalmDetect=1
synclient RBCornerButton=2


## Customize Environment
export CLICOLOR=1
export EDITOR='vim'
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export PAGER='less'
export PATH="/opt/local/bin:/opt/local/libexec/gnubin:$HOME/bin:$PATH"
export TERM='xterm-256color'
