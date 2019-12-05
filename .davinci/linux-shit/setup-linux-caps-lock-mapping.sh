# source this .profile
setxkbmap -option 'caps:ctrl_modifier'
killall xcape &> /dev/null
xcape -e 'Caps_Lock=Escape'
