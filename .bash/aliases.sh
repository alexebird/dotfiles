#!/bin/bash
alias git='hub'
eval "$(hub alias -s)"
alias gb='git branch'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git lg'
alias gla='git lg --branches --remotes --tags'
#alias glo='git waterlog'
#alias glg='git waterlog --graph'
alias gs='git status --short'
alias gds='gd --stat'
#alias gp='git push -u'
alias ag='ag --hidden --smart-case'
#alias ctags-rb='ctags -R --languages=ruby --exclude=.git --exclude=log .'
alias ls='ls -F'
alias l='ls'
alias l1='ls -1'
alias ll='\ls -Fltrh'
alias la='\ls -FltrhA'
alias grep='grep --color=auto'
alias less='less -R'
alias banner='figlet -f graffiti'
alias g='figlet -f doh G'
#alias docker-nodes="docker info | tail -n+6 | head -n-3 | grep -v '└' | tail -n+2"

alias ae='lendup-aws-env'
alias ne='lendup-nomad-env'
eval "$(complete -p | grep lendup-aws-env | awk 'NF{NF--};1') ae"
#eval "$(complete -p | grep lendup-nomad-env | awk 'NF{NF--};1') ne"

alias dontquit='vim /tmp/dontquit'
