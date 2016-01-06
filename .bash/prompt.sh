# pretty prompt for git repos, some links for those intersted in extra credit
# http://effectif.com/git/config
# http://sitaramc.github.com/2-command-line-usage/souped-up-bash-prompt.html
# http://zerowidth.com/blog/2008/11/29/command-prompt-tips.html

aws_env_short()
{
  case "${AWS_ENVIRONMENT}" in
    'development')
      echo 'dev'
      ;;
    'test')
      echo 'test'
      ;;
    'uat')
      echo 'uat'
      ;;
    'integration')
      echo 'i'
      ;;
    'integration1')
      echo 'i1'
      ;;
    'integration2')
      echo 'i2'
      ;;
    'integration3')
      echo 'i3'
      ;;
    *)
      return 1
      ;;
  esac
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

  if [ -n "$SWARM_ENV" ]; then
    if [[ "${SWARM_ENV}" == 'production' ]]; then
      local swarm_env_short='prod'
    else
      local swarm_env_short="${SWARM_ENV}"
    fi
    local swarmy="${BLUE}(dkr:${swarm_env_short})"
  else
    local swarmy=''
  fi

  if aws_env_short > /dev/null ; then
    local awsenv="${YELLOW}(aws:$(aws_env_short))"
  else
    local awsenv=''
  fi

  if [ -n "$TRACKER_TOKEN" ]; then
    local tracker="${PURPLE}(t)"
  else
    local tracker=''
  fi

  PS1="${LIGHT_GRAY}\w${git_color}$(__git_ps1)${awsenv}${swarmy}${tracker}${LIGHT_GRAY}\$${RESET} "
}
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a ; prompt_function"
