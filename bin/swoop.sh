#!/bin/bash

swoop_my_desk_external_modeline()
{
    local ident="${1:-1}"
    local mode="$(cvt 2560 1440 | tail -1 | sed -e's/Modeline //' -e's/"//g' -e"s/_60.00/_${ident}/")"
    echo $mode
}

swoop_my_desk_has_mode()
{
    xrandr -q | grep -A10 "${EXTERNAL} connected" | grep -q "${ASUS_RES}"
}

swoop_show_laptop()
{
    xrandr --output "${EXTERNAL}" --off --output "DP1" --off --output "${LAPTOP}" --auto
}

swoop_show_my_desk_external()
{
    # maybe add the monitor mode we need for the external display
    if ! swoop_my_desk_has_mode ; then
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
        swoop_show_laptop "${LAPTOP}"
    else
        #source ~/.bash/swap-alt-super.sh
        swoop_show_my_desk_external
    fi
}


main() {
  (
    set -e
    #set -v
    set -x
    LAPTOP='eDP1'
    EXTERNAL='DP2'
    ASUS_MODE="$(swoop_my_desk_external_modeline $1)"
    ASUS_RES="$(echo "${ASUS_MODE}" | awk '{print $1}')"
    echo "${ASUS_MODE}"
    swoop
    restart zulip || start zulip
  )
}

main $1
