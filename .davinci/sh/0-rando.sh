export GOPATH="${GOPATH}:${HOME}/.go"

shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="[%d/%m/%y %T] "

#PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a ; prompt_function"

# arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# C-p/C-n
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
