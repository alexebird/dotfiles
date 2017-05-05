export GOPATH="${GOPATH}:${HOME}/.go"

export HISTCONTROL=erasedups
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="[%d/%m/%y %T] "
shopt -s histappend

# arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# C-p/C-n
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
