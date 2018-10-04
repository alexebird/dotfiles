#!/usr/bin/env bash

if [[ "${OSTYPE}" == "linux-gnu" ]] && which xsel > /dev/null; then
  . ~/.davinci/setup-linux-caps-lock-mapping.sh

  #reload key repeat settings
  touch ~/.config/lxsession/Lubuntu/desktop.conf
#elif [[ "${OSTYPE}" == "darwin"* ]]; then
fi

