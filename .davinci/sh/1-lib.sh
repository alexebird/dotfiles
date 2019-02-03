gpg_agent_start() {
  if [[ $(ps -ef | grep gpg-agent | grep -v grep) ]]; then
    export GPG_AGENT_INFO="$(find /tmp -type s -name 'S.gpg-agent' 2> /dev/null):$(ps -ef | grep gpg-agent | grep -v grep | awk '{print $2}'):1"
  fi
}

tab() {
  local name="${@:-}"
  local title

  if [[ -n "${name}" ]]; then
    title="${name}"
  elif [[ ${PWD} == ${HOME} ]]; then
    title='~'
  elif [[ ${PWD} == '/' ]]; then
    title='/'
  else
    if git rev-parse --git-dir > /dev/null; then
      name="$(git rev-parse --show-toplevel)"
      name="$(basename "${name}")"
      title="${name}"
    else
      local slash_count=$(echo -n ${PWD} | tr -d -c '/'  | wc -c)

      if [[ ${slash_count} == 1 ]]; then
        title="/${PWD##*/}"
      else
        # only show last dir
        title="${PWD##*/}"
        # show whole path plus the tilde
        #title="${PWD/#$HOME/\~}"
      fi
    fi
  fi

  echo -n -e "\033]0;${title}\007"
}

unswap_alt_super() {
  setxkbmap -layout us -option ''
}

swap_alt_super() {
  setxkbmap -option altwin:swap_alt_win
}

fix_caps_lock() {
  setxkbmap -layout us -option ''
}

davinci_ps1_custom_coinbase() {
  echo foo
}

# hook pattern for custom prompt variables
_coinbase_assume_role() {
  local new_ps1
  local env_color="${PROMPT_COLOR_LIGHT_YELLOW}"
  local sensitive_env_color="${PROMPT_COLOR_RED_HL_BLACK}"
  local somewhat_sensitive_env_color="${PROMPT_COLOR_LIGHT_YELLOW}"

  local env="${AWS_ACCOUNT_NAME}:${AWS_ACCOUNT_ROLE}"

  # empty prompt section if env isnt set
  if [[ "${env}" == ":" ]] ; then
    echo
    return 0
  fi

  if [[ "${env}" == *production* ]] || [[ "${env}" == *corporate* ]]; then
    new_ps1="${sensitive_env_color}${env}${PROMPT_COLOR_RESET}"
  else
    new_ps1="${env_color}${env}"
  fi

  echo "${new_ps1}"
}
