source ~/.bash/aws-user.sh

alias copy='xsel -ib'
alias paste='xsel -b'
alias h='highlight'

# arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# C-p/C-n
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

gpg_agent_start() {
  #export GPGKEY='F29B9AF3'
  if [[ $(ps -ef | grep gpg-agent | grep -v grep) ]]; then
    export GPG_AGENT_INFO="$(find /tmp -type s -name 'S.gpg-agent' 2> /dev/null):$(ps -ef | grep gpg-agent | grep -v grep | awk '{print $2}'):1"
  fi

  #if test -f $HOME/.gpg-agent-info && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2> /dev/null; then
    #echo gpg-agent should be running
    #GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
    #export GPG_AGENT_INFO
  #else
    #echo starting gpg-agent
    #GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
    #eval 'gpg-agent --daemon --default-cache-ttl 43200'
    #echo $GPG_AGENT_INFO > $HOME/.gpg-agent-info
  #fi
}

function my_git_color_ps1() {
  if test $(git status 2> /dev/null | grep -c :) -eq 0; then
    echo "${COLOR_GREEN}$(__git_ps1)${COLOR_RESET}"
  else
    echo "${COLOR_RED}$(__git_ps1)${COLOR_RESET}"
  fi
}

prompt_function() {
  #PS1="${LIGHT_GRAY}\u@\h: \w${git_color}$(__git_ps1)${LIGHT_GRAY}\$${RESET} "
  #PS1="${LIGHT_GRAY}[$(date +'%I:%M:%S%P %-m/%d')]\n${LIGHT_GRAY}\w${git_color}$(__git_ps1)${LIGHT_GRAY}\$${RESET} "
  #PS1="${LIGHT_GRAY}\w${git_color}$(__git_ps1)${awsenv}${vpn_info}${swarmy}${LIGHT_GRAY}\$${RESET} "

  if [[ -n "${LENDUP_HOME}" ]]; then
    PS1="${COLOR_CYAN}\w$(git_color_ps1)$(aws_env_ps1)$(nomad_env_ps1)$(vpn_ps1)$(terraform_ps1)${COLOR_CYAN}\$${COLOR_RESET} "
  else
    PS1="${COLOR_CYAN}\w$(my_git_color_ps1)${COLOR_CYAN}\$${COLOR_RESET} "
  fi
}

#PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a ; prompt_function"

tab() {
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
      TITLE="${PWD##*/}"
      # show whole path plus the tilde
      #TITLE="${PWD/#$HOME/\~}"
    fi
  else
    TITLE="${1}"
  fi
  echo -n -e "\033]0;${TITLE}\007"
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

#for f in $(find . -type f -a \( -name '*.new.gpg' -prune -o -print \)) ; do echo "re-encrypting '${f}'" ; rm -f "${f/%gpg/new.gpg}" ; gpg -d -o- "${f}" | gpg -e -r D7F63FC6 -r FF32D64D -a -o "${f/%gpg/new.gpg}" && mv "${f/%gpg/new.gpg}" "${f}" ; done

#[Unit]
#Description=Albert

#[Service]
#User=bird
#Group=bird
#Environment=DISPLAY=:0
#Restart=on-failure
#ExecStart=/usr/bin/albert

#[Install]
#WantedBy=multi-user.target

gpg_reencrypt() {
  for f in $(find . -type f -a \( -name '*.new.gpg' -prune -o -print \)) ; do
    echo "re-encrypting '${f}'"
    rm -f "${f/%gpg/new.gpg}"
    cat "${f}" | gpg -d -o- | gpg -e -r FF32D64D -r D7F63FC6 -a -o "${f/%gpg/new.gpg}" && mv "${f/%gpg/new.gpg}" "${f}"
  done
}



#aws s3 sync --exclude=.DS_Store --exclude=* --include=*.gpg . s3://bird-papers/
#aws s3 sync --exclude=.DS_Store --dryrun s3://bird-papers/ .
#aws s3 ls --recursive s3://bird-papers/
#gpg -r FF32D64D -r D7F63FC6 -e 2016/12-december/31/lendup_insurance_card/Image-001.jpg

gpg_import() {
  for f in ~/.bash/gpg/public/*.pub ; do
    gpg --import $f
  done
}

gpg_encrypt() {
  local fname="$1"
  gpg -r FF32D64D -r D7F63FC6 -e "${fname}"
}
