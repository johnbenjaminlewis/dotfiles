# # vim: filetype=sh
# Is this an interactive shell?
if [[ $- =~ i ]] && [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
