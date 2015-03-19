# Key bindings, up/down arrow searches through history
# arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# back/forward keys
#bind '"\eOA": history-search-backward'
#bind '"\eOB": history-search-forward'
# C-p/C-n
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

function hs {
    grep "$*" $HISTFILE
}
