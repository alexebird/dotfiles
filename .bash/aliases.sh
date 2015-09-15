alias genpass='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16; echo'
alias h='history'
alias lock='gnome-screensaver-command --lock'

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
alias pm='git checkout master && git pull && git checkout - && git merge master'

# ag
alias ag='ag --hidden --smart-case'

# ctags
alias ctags-rb='ctags -R --languages=ruby --exclude=.git --exclude=log .'

alias open='xdg-open'

# ls
alias ls='ls -F'
alias l='ls'
alias l1='ls -1'
alias ll='\ls -Fltrh'
alias la='\ls -FltrhA'

# grep
alias grep='grep --color=always'

# less
alias less='less -R'

# urls
alias urlencode='python -c "import urllib, sys; print urllib.quote(sys.argv[1])"'
alias urldecode='python -c "import urllib, sys; print urllib.unquote(sys.argv[1])"'

# awk
alias f1='awk "{print \$1}"'
alias f1x='f1 | xargs'

# fun
alias shit='ssh it'
alias rbj='ruby -rawesome_print -rjson -e'
alias ddd='gpg -d'
alias rr='reset'
alias pssh="ps -eo pid,args | grep ssh | grep -v 'grep\|sshd\|ssh-agent'"
alias myip="ifconfig eth2 | grep -o --color=none '10\.\0\.20\.[[:digit:]]\+'"
alias vpn='sudo ipsec down grnds-sfo && sudo ipsec up grnds-sfo'
#alias enable-pointer='xinput set-prop 13 "Device Enabled" 1'
#alias disable-pointer='xinput set-prop 13 "Device Enabled" 0'
#alias enable-touchpad='xinput set-prop 12 "Device Enabled" 1'
#alias disable-touchpad='xinput set-prop 12 "Device Enabled" 0'

function sshk()
{
    pssh | grep "\b$1\b"
}

function gnb()
{
    git checkout master
    git pull
    git co -b `name-branch $1`
}

function prme()
{
    mkpr $(basename $(pwd)) $(bs)
}

function grnds-dns()
{
    sudo sh -c 'echo search grandrounds.com >> /etc/resolv.conf'
}
