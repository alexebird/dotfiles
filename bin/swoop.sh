#!/bin/bash

set -e
#set -v
set -x

my_desk_external_modeline()
{
    local ident="${1:-1}"
    local mode="$(cvt 2560 1440 | tail -1 | sed -e's/Modeline //' -e's/"//g' -e"s/_60.00/_${ident}/")"
    echo $mode
}

my_desk_has_mode()
{
    xrandr -q | grep -A10 "${EXTERNAL} connected" | grep -q "${ASUS_RES}"
}

show_laptop()
{
    xrandr --output "${EXTERNAL}" --off --output "DP1" --off --output "${LAPTOP}" --auto
}

show_my_desk_external()
{
    # maybe add the monitor mode we need for the external display
    if ! my_desk_has_mode ; then
        set +e
        xrandr --delmode "${EXTERNAL}" "${ASUS_RES}"
        xrandr --rmmode "${ASUS_RES}"
        set -e
        xrandr --newmode ${ASUS_MODE}
        xrandr --addmode "${EXTERNAL}" "${ASUS_RES}"
    fi
    xrandr --output "${LAPTOP}" --off --output "${EXTERNAL}" --mode "${ASUS_RES}"
}

swoop() {
    if xrandr | grep -q "${EXTERNAL} disconnected" ; then
        #source ~/.bash/unswap-alt-super.sh
        show_laptop "${LAPTOP}"
    else
        #source ~/.bash/swap-alt-super.sh
        show_my_desk_external
    fi
}


main()
{
    LAPTOP="eDP1"
    EXTERNAL="DP2"
    ASUS_MODE="$(my_desk_external_modeline $1)"
    ASUS_RES="$(echo ${ASUS_MODE} | awk '{print $1}')"
    echo $ASUS_MODE
    swoop
    restart zulip
}

main $1

#madden()
#{
    #LAPTOP='eDP1'
    #EXTERNAL='DP2'
    #ASUS_MODE='2560x1440'

    #xrandr --delmode "${EXTERNAL}" "${MODE}"
    #xrandr --rmmode "${MODE}"

    #xrandr --newmode "${MODE}" 312.25 2560 2752 3024 3488 1440 1443 1448 1493 -hsync +vsync
    #xrandr --addmode "${EXTERNAL}" "${MODE}"
#}
