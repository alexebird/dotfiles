#!/usr/bin/env bash

# this is a nice pattern that i will probably forget.
#source "$(/usr/bin/dirname "$BASH_SOURCE")/sh/toolme.sh"


#source ~/.davinci/linux-shit/kube-ps1.sh
#KUBE_PS1_SYMBOL_ENABLE='false'
#bird_kube_ps1_cluster_function() {
  #echo "$1" | sed 's|.*/||g'
#}
#KUBE_PS1_CLUSTER_FUNCTION='bird_kube_ps1_cluster_function'

#CTX=$(kubectl ctx -c | sed 's|.*/||g')
#if [[ $CTX == *"staging"* ]]; then
  #KUBE_PS1_CTX_COLOR="black"
  #KUBE_PS1_NS_COLOR="black"
  #KUBE_PS1_BG_COLOR="yellow"
#elif [[ $CTX == *"prod"* ]]; then
  #KUBE_PS1_CTX_COLOR="white"
  #KUBE_PS1_NS_COLOR="white"
  #KUBE_PS1_BG_COLOR="red"
#else
  #KUBE_PS1_CTX_COLOR="green"
  #KUBE_PS1_NS_COLOR="green"
  #KUBE_PS1_BG_COLOR="black"
#fi

PROMPT_COLOR_BLUE='\[\e[0;34m\]'
PROMPT_COLOR_LIGHT_BLUE='\[\e[1;34m\]'
PROMPT_COLOR_PURPLE='\[\e[0;35m\]'
PROMPT_COLOR_LIGHT_PURPLE='\[\e[1;35m\]'
PROMPT_COLOR_RED='\[\e[0;31m\]'
PROMPT_COLOR_LIGHT_RED='\[\e[1;31m\]'
PROMPT_COLOR_GREEN='\[\e[0;32m\]'
PROMPT_COLOR_LIGHT_GREEN='\[\e[1;32m\]'
PROMPT_COLOR_YELLOW='\[\e[0;33m\]'
PROMPT_COLOR_LIGHT_YELLOW='\[\e[1;33m\]'
PROMPT_COLOR_WHITE='\[\e[1;37m\]'
PROMPT_COLOR_LIGHT_GRAY='\[\e[0;37m\]'
PROMPT_COLOR_GRAY='\[\e[1;30m\]'
PROMPT_COLOR_LIGHT_CYAN='\[\e[0;36m\]'
PROMPT_COLOR_CYAN='\[\e[1;36m\]'
PROMPT_COLOR_RESET='\[\e[0m\]'

# Highlighted
# bold white on bright red
PROMPT_COLOR_YELLOW_HL='\[\e[0;30;43m\]'
PROMPT_COLOR_RED_HL_BLACK='\[\e[0;30;41m\]'
PROMPT_COLOR_RED_HL='\[\e[1;97;101m\]'

# Blinking
PROMPT_COLOR_YELLOW_BL='\[\e[5;30;43m\]'

# stolen from git itself
__davinci_git_ps1 ()
{
  local g="$(\git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    local r
    local b
    if [ -d "$g/rebase-apply" ]
    then
      if test -f "$g/rebase-apply/rebasing"
      then
        r="|REBASE"
      elif test -f "$g/rebase-apply/applying"
      then
        r="|AM"
      else
        r="|AM/REBASE"
      fi
      b="$(\git symbolic-ref HEAD 2>/dev/null)"
    elif [ -f "$g/rebase-merge/interactive" ]
    then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
    elif [ -d "$g/rebase-merge" ]
    then
      r="|REBASE-m"
      b="$(cat "$g/rebase-merge/head-name")"
    elif [ -f "$g/MERGE_HEAD" ]
    then
      r="|MERGING"
      b="$(\git symbolic-ref HEAD 2>/dev/null)"
    else
      if [ -f "$g/BISECT_LOG" ]
      then
        r="|BISECTING"
      fi
      if ! b="$(\git symbolic-ref HEAD 2>/dev/null)"
      then
        if ! b="$(\git describe --exact-match HEAD 2>/dev/null)"
        then
          b="$(cut -c1-7 "$g/HEAD")..."
        fi
      fi
    fi

    if [ -n "$1" ]; then
      printf "$1" "${b##refs/heads/}$r"
    else
      printf "(%s)" "${b##refs/heads/}$r"
    fi
  fi
}

_git_color_ps1() {
  local g="$(\git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    if test $(\git status --porcelain | wc -l) -eq 0 ; then
      echo "${PROMPT_COLOR_GREEN}$(__davinci_git_ps1)${PROMPT_COLOR_RESET}"
    else
      echo "${PROMPT_COLOR_RED}$(__davinci_git_ps1)${PROMPT_COLOR_RESET}"
    fi
  fi
}

_git_performant_ps1() {
  local g="$(\git rev-parse --git-dir 2>/dev/null)"
  echo "${PROMPT_COLOR_GRAY}$(__davinci_git_ps1)${PROMPT_COLOR_RESET}"
}

_davinci_env_ps1() {
  #local parens_color="${PROMPT_COLOR_LIGHT_GREEN}"

  #if declare -F | grep -q _coinbase_assume_role; then
    #local new_ps1="$(_coinbase_assume_role)"
    #if [[ -n "${new_ps1}" ]]; then
      #echo "${parens_color}(${new_ps1}${parens_color})${PROMPT_COLOR_RESET}"
    #else
      #echo
    #fi
  #fi

  local new_ps1
  local env_color="${PROMPT_COLOR_LIGHT_YELLOW}"
  local sensitive_env_color="${PROMPT_COLOR_RED_HL_BLACK}"
  local somewhat_sensitive_env_color="${PROMPT_COLOR_LIGHT_YELLOW}"

  # empty prompt section if env isnt set
  if [[ -z "${DAVINCI_ENV}" ]] ; then
    echo
    return 0
  fi

  if [[ "${DAVINCI_ENV}" == "prod" ]] ; then
    new_ps1="${sensitive_env_color}${DAVINCI_ENV}${PROMPT_COLOR_RESET}"
  elif [[ "${DAVINCI_ENV}" == "dev" ]] ; then
    new_ps1="${somewhat_sensitive_env_color}${DAVINCI_ENV}${PROMPT_COLOR_RESET}"
  else
    new_ps1="${env_color}${DAVINCI_ENV}"
  fi

  echo "${new_ps1}"
}

_prompt_kubecontext() {
  if [[ -f $KUBECONFIG || -f ~/.kube/config ]] ; then
    WARNING=""
    if [[ -f ~/.kube/config ]]; then
      prompt_segment red yellow "KUBECONFIG EXISTS"
    fi
    CTX=$(kubectx -c | sed 's|.*/||g')
    CNS=$(kubens -c)
    if [[ $CTX == *"tooling"* ]]; then
         prompt_segment green black "(⎈ ${CNS}:${CTX})"
    elif [[ $CTX == *"nonprod"* ]]; then
         prompt_segment yellow black "(⎈ ${CNS}:${CTX})"
    elif [[ $CTX == *"prod"* ]]; then
         prompt_segment red yellow "(⎈ ${CNS}:${CTX})"
    else
         prompt_segment green black "(⎈ ${CNS}:${CTX})"
    fi
  fi
}

_davinci_safety_ps1() {
  if [ ${ZSH_VERSION} ]; then
    [ "${ORIG_PS1}" ] || ORIG_PS1="${PS1}"
    PS1="${ORIG_PS1} $(_davinci_env_ps1)%# "
  elif [ ${BASH_VERSION} ]; then
    _PROMPT_COLOR="${DAVINCI_PROMPT_COLOR}"
    if [[ "${USER}" == "root" ]]; then
      _PROMPT_COLOR="${PROMPT_COLOR_LIGHT_RED}"
    fi

    # change prompt coloring based on performance
    if [[ "$(git rev-parse --show-toplevel 2>/dev/null)" = /Users/bird/dev* ]]; then
      GIT_PART="$(_git_performant_ps1)"
    else
      GIT_PART="$(_git_color_ps1)"
    fi

    #if [[ "${PWD}" == *"/go-repo"* ]] || [[ "${PWD}" == *"/infra-2.0"* ]] ; then
      #K8S_PART=" ${PROMPT_COLOR_RESET}$(kube_ps1)"

      #CTX=$(kubectl ctx -c | sed 's|.*/||g')
      KCTX="$(yq e '.current-context | split("_") | .[1] | split("-") | .[2]' ~/.kube/config)"
      KNS="$(yq e '.current-context as $ctx | .contexts[] | select(.name == $ctx) | .context.namespace // "default"' ~/.kube/config)"
      #CNS=$(kubectl ns -c)
      #K8S_PART=" ${PROMPT_COLOR_LIGHT_BLUE}(${CTX}:${CNS})"
      if [[ "${KCTX}" == "pizzathehutt" ]]; then
        K8S_PART=" ${PROMPT_COLOR_LIGHT_BLUE}(${PROMPT_COLOR_RED_HL_BLACK}${KCTX}${PROMPT_COLOR_RESET}${PROMPT_COLOR_LIGHT_BLUE}:${KNS})"
      else
        K8S_PART=" ${PROMPT_COLOR_LIGHT_BLUE}(${KCTX}:${KNS})"
      fi
    #else
      #K8S_PART=''
    #fi

    PS1="${_PROMPT_COLOR}${DAVINCI_PROMPT_PREFIX}${K8S_PART} ${GIT_PART}$(_davinci_env_ps1)${_PROMPT_COLOR}\$${PROMPT_COLOR_RESET} "
  fi
}

_davinci_set_safety_prompt_command() {
  PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a ; _davinci_safety_ps1"
}

#_davinci_path_first_component() {
  #_davinci_path_components | head -1
#}

#_davinci_path_components() {
  #echo "${DAVINCI_PATH}" | sed -e's/:/\n/'
#}

#_davinci_source_davinci_path_components() {
  #for path_ in $(_davinci_path_components); do
    #if [[ -d "${path_}/bin" ]]; then
        #export PATH="${path_}/bin:${PATH}"
    #fi
  #done
#}

#_davinci_source_bash() {
  #for f in $(find ${DAVINCI_CLONE}/sh/ -type f -name '*.sh' | sort); do
    #. "${f}"
  #done
#}

#_davinci_source_user_dot_davinci() {
  #for path_ in $(_davinci_path_components); do
    #if [[ -d "${path_}/sh" ]]; then
      #for f in $(find "${path_}/sh" -type f -name '*.sh' | sort); do
        #. "${f}"
      #done
    #fi
  #done
#}

#davinci-toolme() {
  #_davinci_source_davinci_path_components
  #_davinci_source_bash
  #_davinci_source_user_dot_davinci
  ##davincienv::source_auto
#}

# config env vars
# ===============
#

# general paths
#[ -z "${DAVINCI_CLONE}" ]    && export DAVINCI_CLONE="${HOME}/davinci"
#[ -z "${DAVINCI_HOME}" ]     && { echo "must set DAVINCI_HOME"; return 1 ; }
#[ -z "${DAVINCI_PATH}" ]     && export DAVINCI_PATH="${HOME}/.davinci"
#[ -z "${DAVINCI_ENV_PATH}" ] && export DAVINCI_ENV_PATH="${HOME}/.davinci-env"

# /end config env vars
# ====================

#export PATH="${DAVINCI_CLONE}/bin:${PATH}"
#export MANPATH="${DAVINCI_CLONE}/man:${MANPATH}"

#davinci-toolme

# this config has to be done after toolme since it references a color

#if _davinci_opt_use_safety_prompt; then
  #[ ${ZSH_VERSION:-} ] && precmd() { _davinci_safety_ps1; }
  #[ ${BASH_VERSION:-} ] && _davinci_set_safety_prompt_command
#fi

export DAVINCI_PROMPT_COLOR="${PROMPT_COLOR_CYAN}"
export DAVINCI_PROMPT_PREFIX="\W"
_davinci_set_safety_prompt_command



export GOPATH="${HOME}/go"
export EDITOR='vim'

shopt -s histappend
export HISTCONTROL='ignoreboth:erasedups'
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="[%d/%m/%y %T] "

# arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# C-p/C-n
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
# ALT-p/ALT-n (as workaround for weird docker cli behavior)
# doesnt work...wtf?
#bind '"\M-p": history-search-backward'
#bind '"\M-n": history-search-forward'

#########################################################################
# formerly lib.sh

tab() {
  local name="${@:-}"
  local title

  if [[ "${name}" == "pwd" ]]; then
    title="$(basename "$(pwd)")"
  elif [[ -n "${name}" ]]; then
    title="${name}"
  elif [[ ${PWD} == ${HOME} ]]; then
    title='~'
  elif [[ ${PWD} == '/' ]]; then
    title='/'
  elif git rev-parse --git-dir > /dev/null; then
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

  echo -n -e "\033]0;${title}\007"
}

orphaned_local_branches() {
  local remotes=$(git branch -a | grep '  remotes' | sed -e's|  remotes/origin/||')
  for e in $(git branch | sed -e's/\(* \)\|\(  \)//') ; do
    echo "$remotes" | grep -q $e || echo "$e"
  done
}

# hook pattern for custom prompt variables
#_coinbase_assume_role() {
  #local new_ps1
  #local env_color="${PROMPT_COLOR_LIGHT_YELLOW}"
  #local sensitive_env_color="${PROMPT_COLOR_RED_HL_BLACK}"
  #local somewhat_sensitive_env_color="${PROMPT_COLOR_LIGHT_YELLOW}"

  #local env="${AWS_ACCOUNT_NAME}:${AWS_ACCOUNT_ROLE}"

  ## empty prompt section if env isnt set
  #if [[ "${env}" == ":" ]] ; then
    #echo
    #return 0
  #fi

  #if [[ "${env}" == *production* ]] || [[ "${env}" == *corporate* ]]; then
    #new_ps1="${sensitive_env_color}${env}${PROMPT_COLOR_RESET}"
  #else
    #new_ps1="${env_color}${env}"
  #fi

  #echo "${new_ps1}"
#}

whereisfunc() {
  shopt -s extdebug ; declare -F "$1" ; shopt -s extdebug
}

#########################################################################
# formerly aliases.sh


#if which hub > /dev/null ; then
  #alias git='hub'
#fi

alias gb='git branch'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git lg'
alias gla='git lg --branches --remotes --tags'
#alias glo='git waterlog'
#alias glg='git waterlog --graph'
alias gs='git status --short --branch'
alias gds='gd --stat'
#alias gp='git push -u'
alias ag='ag --hidden --smart-case'
#alias ctags-rb='ctags -R --languages=ruby --exclude=.git --exclude=log .'
alias ls='ls -F --color=auto'
alias l='ls'
alias l1='\ls -1'
alias ll='\ls -Fltrh --color=auto'
alias la='\ls -Fltrha --color=auto'
alias grep='grep --color=auto'
alias less='less -R'
alias banner='figlet -f graffiti'
alias g='figlet -f doh G'
alias gf='figlet -f doh GF'
#alias docker-nodes="docker info | tail -n+6 | head -n-3 | grep -v '└' | tail -n+2"
alias h='highlight'

alias dontquit='vim /tmp/dontquit'
#alias de='davinci-env'
#alias barf='gpgp find-secrets'
#alias eat='gpgp copy-secret'

# git
alias bs='git branch-search'
alias fco='git fast-checkout'
alias pm='git checkout master && git pull && git checkout - && git merge master'
alias git-track='git branch --set-upstream-to=origin/`bs` `bs`'

alias dp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Names}}"'
alias dpp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias urlencode='python -c "import urllib.parse, sys; print(urllib.parse.quote_plus(sys.argv[1]))"'
alias urldecode='python -c "import urllib.parse, sys; print(urllib.parse.unquote_plus(sys.argv[1]))"'

if which nvim > /dev/null ; then
  alias vim=nvim
fi

if ! uname -a | grep -q Darwin ; then
  alias open='xdg-open'
  alias copy='xsel -ib'
  alias paste='xsel -b'
else
  alias copy='pbcopy'
  alias paste='pbpaste'
fi

hs() {
    history | grep -i -- "$*"
}

f() {
  awk "{print \$$1}"
}

fl() {
  awk '{print $NF}'
}

for i in $(seq 20); do
  eval "alias f$i='f $i'"
done

#search-and-replace() {
  #local pattern="$1"
  #local from="$2"
  #local to="$3"
  #find . -type d -name .git -prune -o -type f -name "${pattern}" -print -exec sed -i -e"s/${from}/${to}/g" {} \;
#}

#google() {
  #local query=$(python -c "import urllib, sys; print urllib.quote(sys.argv[1])" "$*")
  #google-chrome https://www.google.com/search?q=${query}
#}

if [[ "${OSTYPE}" == "linux-gnu" ]] && which xsel > /dev/null; then
  . ~/.davinci/linux-shit/setup-linux-caps-lock-mapping.sh

  #reload key repeat settings
  touch ~/.config/lxsession/Lubuntu/desktop.conf
#elif [[ "${OSTYPE}" == "darwin"* ]]; then
fi

fix_caps_lock() {
  setxkbmap -layout us -option ''
}
