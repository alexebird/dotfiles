export GOROOT="/usr/local/go"
export GOPATH="${HOME}/go"

shopt -s histappend
export HISTCONTROL='ignoreboth:erasedups'
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="[%d/%m/%y %T] "

# arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# C-p/C-n
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
