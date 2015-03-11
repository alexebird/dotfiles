# remap caps lock to control
setxkbmap -option 'caps:ctrl_modifier'

# make caps lock be esc when pressed alone
killall xcape &> /dev/null
~/bin/xcape -e 'Caps_Lock=Escape'

# reload key repeat settings
touch ~/.config/lxsession/Lubuntu/desktop.conf
