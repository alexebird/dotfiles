#!/bin/bash

#swoop_my_desk_external_modeline()
#{
    #local ident="${1:?must pass ident}"

    ## shitty dell
    ##local x='1920'
    ##local y='1200'

    #local x='2560'
    #local y='1440'

    #local refresh='59.95'

    #local mode="$(cvt $x $y | tail -1 | sed -e's/Modeline //' -e's/"//g' -e"s/_60.00/_${refresh}/")"
    #echo $mode
#}

swoop_external_name() {
  xrandr -q | grep \ connected | grep -v 'eDP-1' | awk '{print $1}'
}

#swoop_my_desk_has_mode()
#{
    #xrandr -q | grep -A10 "${EXTERNAL} connected" | grep -q "${ASUS_RES}"
#}

swoop_show_laptop()
{
  local laptop="${1}" ; shift
  local external="${1}" ; shift
  xrandr --output "${external}" --off --output "${laptop}" --auto
}

#swoop_show_my_desk_external()
#{
  ## maybe add the monitor mode we need for the external display
  #if ! swoop_my_desk_has_mode ; then
    #set +e
    #xrandr --delmode "${EXTERNAL}" "${ASUS_RES}"
    #xrandr --rmmode "${ASUS_RES}"
    #set -e
    #xrandr --newmode ${ASUS_MODE}
    #xrandr --addmode "${EXTERNAL}" "${ASUS_RES}"
  #fi
  #xrandr --output "${LAPTOP}" --off --output "${EXTERNAL}" --mode "${ASUS_RES}"
#}

#swoop() {
  #local laptop="${1}" ; shift
  #local external="${1}" ; shift
  #if xrandr | grep -q "${external} disconnected" ; then
      #swoop_show_laptop "${laptop}" "${external}"
  #else
      #swoop_show_my_desk_external "${laptop}" "${external}"
  #fi
#}

undock() {
  local laptop="${1}" ; shift
  local external="${1}" ; shift
  swoop_show_laptop  "${laptop}" "${external}"
}

#external() {
  #local laptop="${1}" ; shift
  #local external="${1}" ; shift
  #swoop_show_my_desk_external
#}

swarp() {
  local laptop="${1}" ; shift
  local external="${1}" ; shift

  if xrandr -q | grep -q "${external} disconnected" ; then
    xrandr --output "${laptop}" --auto --output "${external}" --off
  else
    xrandr --output "${laptop}" --off --output "${external}" --auto
  fi
}

main() {
  (
    set -e

    if [[ "${1}" == "-h" ]]; then
      cat <<HERE
usage: swoop.sh [-h -v] SUBCMD

SUBCMD
- swoop (classic)
- swarp (new style swoop)
- undock
- external
HERE
      exit 0
    elif [[ "${1}" == "-v" ]]; then
      shift
      set -x
    fi

    subcmd="${1:?must pass subcommand}"
    logger -tswoop 'starting...'
    logger -tswoop "subcmd: ${subcmd}"
    LAPTOP='eDP-1'
    #ASUS_MODE="$(swoop_my_desk_external_modeline "1")"
    #ASUS_RES="$(echo "${ASUS_MODE}" | awk '{print $1}')"
    local external="$(swoop_external_name)"
    logger -tswoop "laptop: ${LAPTOP}"
    logger -tswoop "external: ${external}"
    #logger -tswoop "external-modeline: ${ASUS_MODE}"
    #logger -tswoop "external-res: ${ASUS_RES}"
    ${1} "${LAPTOP}" "$(swoop_external_name)"
    source ~/.davinci/sh/remap_keys.sh
  )
}

main "${@}"
