#!/bin/bash

swoop_my_desk_external_modeline()
{
    local ident="${1:?must pass ident}"

    local x='1920'
    local y='1200'
    local refresh='59.95'

    local mode="$(cvt $x $y | tail -1 | sed -e's/Modeline //' -e's/"//g' -e"s/_60.00/_${refresh}/")"
    echo $mode
}

swoop_my_desk_has_mode()
{
    xrandr -q | grep -A10 "${EXTERNAL} connected" | grep -q "${ASUS_RES}"
}

swoop_show_laptop()
{
    xrandr --output "${EXTERNAL}" --off --output "${LAPTOP}" --auto
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
        swoop_show_laptop
    else
        swoop_show_my_desk_external
    fi
}

undock() {
    swoop_show_laptop
}

external() {
    swoop_show_my_desk_external
}

main() {
  (
    set -e
    #set -v
    #set -x
    subcmd="${1:-swoop}"
    logger -tswoop 'starting...'
    logger -tswoop "subcmd: ${subcmd}"
    LAPTOP='eDP-1'
    EXTERNAL='DP-2-1'
    ASUS_MODE="$(swoop_my_desk_external_modeline "1")"
    ASUS_RES="$(echo "${ASUS_MODE}" | awk '{print $1}')"
    logger -tswoop "laptop: ${LAPTOP}"
    logger -tswoop "external: ${EXTERNAL}"
    logger -tswoop "external-modeline: ${ASUS_MODE}"
    logger -tswoop "external-res: ${ASUS_RES}"
    ${1}
    source ~/.davinci/sh/remap_keys.sh
  )
}

main $1
