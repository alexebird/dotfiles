alias genpass='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16; echo'
alias h='history'

# git
alias git='hub'
alias gb='git branch'
alias gci='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git lg'
alias gla='git lg --branches --remotes --tags'
alias glo='git lg --oneline'
alias gs='git status'
#alias gp='git push'
#alias gpp='git pull'
alias bs='git branch-search'
alias fco='git fast-checkout'

# ag
alias ag='ag --hidden --smart-case'

# ctags
alias ctags-rails='ctags -R --languages=ruby --exclude=.git --exclude=log .'

alias open='xdg-open'

# ls
alias ls='ls -F'
alias l='ls'
alias ll='\ls -Fltrh'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# urls
alias urlencode='python -c "import urllib, sys; print urllib.quote(sys.argv[1])"'
alias urldecode='python -c "import urllib, sys; print urllib.unquote(sys.argv[1])"'
