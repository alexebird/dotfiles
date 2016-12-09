source ~/.bash/aws-user.sh

for f in $(find ~/.bash/lendup/bash/ -type f -name '*.sh'); do
  source "${f}"
done

alias genpass='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16; echo'
#alias lock='lxlock'
alias copy='xsel -ib'
alias paste='xsel -b'
#alias hell='honesty-environment local'
alias dp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Names}}"'
alias dpp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias wdp="watch -n1 'docker ps --format \"table {{.ID}}\t{{.Status}}\t{{.Names}}\"'"
alias h='highlight'

#alias h='history'
hs() {
    history | grep -i "$*"
}

# git
#alias git='hub'
#eval "$(hub alias -s)"
alias gb='git branch'
alias gci='git commit'
alias gco='git checkout'
alias gcobt='git checkout -t -b'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git lg'
alias gla='git lg --branches --remotes --tags'
alias glo='git waterlog'
alias glg='git waterlog --graph'
alias gs='git status --short'
alias gds='gd --stat'
alias gp='git push -u'
alias bs='git branch-search'
alias fco='git fast-checkout'
alias pm='git checkout master && git pull && git checkout - && git merge master'
alias git-prune-local='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias git-track='git branch --set-upstream-to=origin/`bs` `bs`'

orphaned_local_branches() {
  local remotes=$(git branch -a | grep '  remotes' | sed -e's|  remotes/origin/||')
  for e in $(git branch | sed -e's/\(* \)\|\(  \)//') ; do
    echo "$remotes" | grep -q $e || echo "$e"
  done
}


# ag
alias ag='ag --hidden --smart-case'

# ctags
alias ctags-rb='ctags -R --languages=ruby --exclude=.git --exclude=log .'

if ! uname -a | grep -q Darwin ; then
  alias open='xdg-open'
else
  alias copy='pbcopy'
  alias paste='pbpaste'
fi

# ls
alias ls='ls -F'
alias l='ls'
alias l1='ls -1'
alias ll='\ls -Fltrh'
alias la='\ls -FltrhA'

# grep
alias grep='grep --color=auto'
alias erep='egrep --color=auto'

# less
alias less='less -R'

# urls
alias urlencode='python -c "import urllib, sys; print urllib.quote(sys.argv[1])"'
alias urldecode='python -c "import urllib, sys; print urllib.unquote(sys.argv[1])"'


# fun
alias upgrade='sudo apt-get -y update && sudo apt-get -y dist-upgrade'
#alias shit='ssh it'
#alias rbj='ruby -rawesome_print -rjson -e'
#alias ddd='gpg -d'
#alias rr='reset'
#alias pssh="ps -eo pid,args | grep ssh | grep -v 'grep\|sshd\|ssh-agent'"
#alias myip="ifconfig eth2 | grep -o --color=none '10\.\0\.20\.[[:digit:]]\+'"
alias banner='figlet -f graffiti'
#alias vpn='sudo ipsec down grnds-sfo && sudo ipsec up grnds-sfo'
#alias rz='restart zulip || start zulip'
#alias enable-pointer='xinput set-prop 13 "Device Enabled" 1'
#alias disable-pointer='xinput set-prop 13 "Device Enabled" 0'
#alias enable-touchpad='xinput set-prop 12 "Device Enabled" 1'
#alias disable-touchpad='xinput set-prop 12 "Device Enabled" 0'
#alias bat='for i in 0 1; do echo BAT$i ; upower -i "/org/freedesktop/UPower/devices/battery_BAT${i}" | grep --color=never "time to empty" ; done'
#alias bundle-cache-ls='aws s3 ls s3://grnds-test-coreos/'
alias g='figlet -f doh G'

# docker
#alias dps='docker ps -a | less -S'
#alias docker-nodes="docker info | tail -n+6 | head -n-3 | grep -v '└' | tail -n+2"
#alias consul='docker run --rm --name consul gliderlabs/consul'

f() {
  awk "{print \$$1}"
}

fl() {
  awk '{print $NF}'
}

for i in $(seq 10); do
  eval "alias f$i='f $i'"
done

#sar() {
#  local pattern=$1
#  local from=$2
#  local to=$3
#  find . -type d -name .git -prune -o -type f -name "${pattern}" -print -exec sed -i -e"s/${from}/${to}/g" {} \;
#}

google() {
  local query=$(python -c "import urllib, sys; print urllib.quote(sys.argv[1])" "$*")
  google-chrome https://www.google.com/search?q=${query}
}

# arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# C-p/C-n
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

#remap_capslock() {
  # remap caps lock to control
#  setxkbmap -option 'caps:ctrl_modifier'

  # make caps lock be esc when pressed alone
#  killall xcape &> /dev/null
#  ~/bin/xcape -e 'Caps_Lock=Escape'

  # reload key repeat settings
#  touch ~/.config/lxsession/Lubuntu/desktop.conf
#}

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

prompt_function() {
  local        BLUE='\[\e[0;34m\]'
  local  LIGHT_BLUE='\[\e[1;34m\]'
  local      PURPLE='\[\e[0;35m\]'
  local LIGHT_PURPLE='\[\e[1;35m\]'
  local         RED='\[\e[0;31m\]'
  local   LIGHT_RED='\[\e[1;31m\]'
  local       GREEN='\[\e[0;32m\]'
  local LIGHT_GREEN='\[\e[1;32m\]'
  local      YELLOW='\[\e[0;33m\]'
  local LIGHT_YELLOW='\[\e[1;33m\]'
  local       WHITE='\[\e[1;37m\]'

  local  LIGHT_GRAY='\[\e[0;37m\]'
  local        GRAY='\[\e[1;30m\]'

  local  LIGHT_CYAN='\[\e[0;36m\]'
  local        CYAN='\[\e[1;36m\]'

  local       RESET='\[\e[0m\]'

  # previous_return_value=$?;
  # case $previous_return_value in
  #   0)
  #     prompt_color="${RESET}"
  #   ;;
  #   1)
  #     prompt_color="${LIGHT_RED}"
  #   ;;
  #   *)
  #     prompt_color="${LIGHT_YELLOW}"
  #   ;;
  # esac
  # use "${prompt_color}\$${RESET}" instead of "\$" below

  if test $(git status 2> /dev/null | grep -c :) -eq 0; then
    local git_color="${GREEN}"
  else
    local git_color="${RED}"
  fi
  #PS1="${LIGHT_GRAY}\u@\h: \w${git_color}$(__git_ps1)${LIGHT_GRAY}\$${RESET} "
  #PS1="${LIGHT_GRAY}[$(date +'%I:%M:%S%P %-m/%d')]\n${LIGHT_GRAY}\w${git_color}$(__git_ps1)${LIGHT_GRAY}\$${RESET} "

#  if [ -n "$SWARM_ENV" ]; then
#    if [[ "${SWARM_ENV}" == 'production' ]]; then
#      local swarm_env_short='prod'
#    else
#      local swarm_env_short="${SWARM_ENV}"
#    fi
#    local swarmy="${BLUE}(${swarm_env_short})"
#  else
#    local swarmy=''
#  fi
#
#  if aws_env_short > /dev/null ; then
#    local awsenv="${YELLOW}($(aws_env_short))"
#  else
#    local awsenv=''
#  fi
#
#  if ! uname -a | grep -q Darwin; then
#    if gr-my-vpn-ip > /dev/null ; then
#      local vpn_info="${PURPLE}(v)"
#    else
#      local vpn_info=''
#    fi
#  fi

  #if [ -n "$TRACKER_TOKEN" ]; then
    #local tracker="${PURPLE}(t)"
  #else
    #local tracker=''
  #fi

  local vpn="$(tunnelblick_ps1)"
  if [ -n "${vpn}" ]; then
    #vpn="${CYAN}(\e[1;0;41m${vpn}${RESET}${CYAN})"
    vpn="\e[1;0;41m${vpn}${RESET}"
  else
    vpn=''
  fi

  local tfapply="${TF_ALLOW_APPLY}"
  if [ -n "${tfapply}" ]; then
    tfapply="\e[0;30;43mtf!!!${RESET}"
  else
    tfapply=''
  fi

  local nomad_env="${NOMAD_ENV}"
  if [ -n "${nomad_env}" ]; then
    nomad_env="${BLUE}(${nomad_env})${RESET}"
  else
    nomad_env=''
  fi

  #PS1="${LIGHT_GRAY}\w${git_color}$(__git_ps1)${awsenv}${vpn_info}${swarmy}${LIGHT_GRAY}\$${RESET} "
  PS1="${CYAN}\w${git_color}$(__git_ps1)${nomad_env}${vpn}${tfapply}${CYAN}\$${RESET} "
}

PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a ; prompt_function"

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
#if ! uname -a | grep -q Darwin; then
#  cd()    { __zsh_like_cd cd    "$@" && tab_title; }
#  pushd() { __zsh_like_cd pushd "$@" && tab_title; }
#  popd()  { __zsh_like_cd popd  "$@" && tab_title; }
#fi

#tab

unswap_alt_super() {
  setxkbmap -layout us -option ''
  remap_capslock
}

swap_alt_super() {
  setxkbmap -option altwin:swap_alt_win
}

fix_caps_lock() {
  setxkbmap -layout us -option ''
}

whereisfunc() {
  shopt -s extdebug ; declare -F "$1" ; shopt -s extdebug
}

name-branch() {
  paste | ruby -e'puts STDIN.read.gsub(/[\s_]+/, "-").downcase'
}

#for f in $(find . -type f -a \( -name '*.new.gpg' -prune -o -print \)) ; do echo "re-encrypting '${f}'" ; rm -f "${f/%gpg/new.gpg}" ; gpg -d -o "${f}" | gpg -e r <PUBKEY> -r ... -a -o "${f/%gpg/new.gpg}" && mv "${f/%gpg/new.gpg}" "${f}" ; done
