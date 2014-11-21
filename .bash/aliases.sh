alias genpass='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16; echo'

# git
alias gb='git branch'
alias gci='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git lg'
alias gla='git lg --branches --remotes --tags'
alias gs='git status'

# ag
alias ag='ag --hidden --smart-case'

# ctags
alias ctags-rails='ctags -R --languages=ruby --exclude=.git --exclude=log .'
