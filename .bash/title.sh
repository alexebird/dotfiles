function tab_title() {
  if [[ ${PWD} == ${HOME} ]]; then
    TITLE='~'
  elif [[ ${PWD} == '/' ]]; then
    TITLE='/'
  elif [ -z "$1" ]; then
    SLASH_COUNT=$(echo -n ${PWD} | tr -d -c '/'  | wc -c)
    if [[ ${SLASH_COUNT} == 1 ]]; then
      TITLE="/${PWD##*/}"
    else
      # only show last dir
      #TITLE="${PWD##*/}"
      # show whole path plus the tilde
      TITLE="${PWD/#$HOME/\~}"
    fi
  else
    TITLE="${1}"
  fi
  echo -n -e "\033]0;${TITLE}\007"
}

# auto-title
cd() { builtin cd "$@" && tab_title; }
pushd() { builtin pushd "$@" && tab_title; }
popd() { builtin popd "$@" && tab_title; }
tab_title
