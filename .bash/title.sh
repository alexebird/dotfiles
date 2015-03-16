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
#cd()    { __zsh_like_cd cd    "$@" && tab_title; }
#pushd() { __zsh_like_cd pushd "$@" && tab_title; }
#popd()  { __zsh_like_cd popd  "$@" && tab_title; }
#tab_title
