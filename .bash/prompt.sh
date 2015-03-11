# pretty prompt for git repos, some links for those intersted in extra credit
# http://effectif.com/git/config
# http://sitaramc.github.com/2-command-line-usage/souped-up-bash-prompt.html
# http://zerowidth.com/blog/2008/11/29/command-prompt-tips.html
prompt_function() {
  local        BLUE='\[\033[0;34m\]'
  local  LIGHT_BLUE='\[\033[1;34m\]'
  local      PURPLE='\[\033[0;35m\]'
  local LIGHT_PURPLE='\[\033[1;35m\]'
  local         RED='\[\033[0;31m\]'
  local   LIGHT_RED='\[\033[1;31m\]'
  local       GREEN='\[\033[0;32m\]'
  local LIGHT_GREEN='\[\033[1;32m\]'
  local      YELLOW='\[\033[0;33m\]'
  local LIGHT_YELLOW='\[\033[1;33m\]'
  local       WHITE='\[\033[1;37m\]'
  local  LIGHT_GRAY='\[\033[0;37m\]'
  local        GRAY='\[\033[1;30m\]'
  local       RESET='\[\033[0m\]'

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
    git_color="${GREEN}"
  else
    git_color="${RED}"
  fi
  PS1="${LIGHT_GRAY}\u@\h: \w${git_color}$(__git_ps1)${LIGHT_GRAY}\$${RESET} "
}
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} prompt_function"
