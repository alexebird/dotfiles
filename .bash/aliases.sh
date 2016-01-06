alias genpass='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c16; echo'
alias h='history'
alias lock='gnome-screensaver-command --lock'

# git
alias git='hub'
alias gb='git branch'
alias gci='git commit'
alias gco='git checkout'
alias gcobt='git checkout -t -b'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git lg'
alias gla='git lg --branches --remotes --tags'
alias glo='git lg --oneline'
alias gs='git status --short'
alias gp='git push -u'
alias bs='git branch-search'
alias fco='git fast-checkout'
alias pm='git checkout master && git pull && git checkout - && git merge master'
alias git-prune-local='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias git-track='git branch --set-upstream-to=origin/`bs` `bs`'

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


# fun
alias shit='ssh it'
alias rbj='ruby -rawesome_print -rjson -e'
alias ddd='gpg -d'
alias rr='reset'
alias pssh="ps -eo pid,args | grep ssh | grep -v 'grep\|sshd\|ssh-agent'"
alias myip="ifconfig eth2 | grep -o --color=none '10\.\0\.20\.[[:digit:]]\+'"
alias banner='figlet -f graffiti'
alias vpn='sudo ipsec down grnds-sfo && sudo ipsec up grnds-sfo'
alias rz='restart zulip'
#alias enable-pointer='xinput set-prop 13 "Device Enabled" 1'
#alias disable-pointer='xinput set-prop 13 "Device Enabled" 0'
#alias enable-touchpad='xinput set-prop 12 "Device Enabled" 1'
#alias disable-touchpad='xinput set-prop 12 "Device Enabled" 0'
alias bat='for i in 0 1; do echo BAT$i ; upower -i "/org/freedesktop/UPower/devices/battery_BAT${i}" | grep "time to empty" ; done'
alias bundle-cache-ls='aws s3 ls s3://grnds-test-coreos/'
bundle-cache-rm()
{
    aws s3 rm s3://grnds-test-coreos/${1}-bundle.tar.gz
}

# docker
alias dps='docker ps -a | less -S'
alias docker-nodes="docker info | tail -n+6 | head -n-3 | grep -v '└' | tail -n+2"
alias consul='docker run --rm --name consul gliderlabs/consul'

# grnds
alias ae='gr-aws-environment'
alias ae-dev='ae development'
alias ae-test='ae test'
alias ae-i3='ae integration3'
alias ae-uat='ae uat'
alias te='tracker-environment'
alias pe='papertrail-environment'

#function gnb()
#{
    #git checkout master
    #git pull
    #git co -b `name-branch $1`
#}

grnds_dns()
{
    sudo sh -c 'echo search grandrounds.com >> /etc/resolv.conf'
}

f()
{
    awk "{print \$$1}"
}

for i in $(seq 10); do
    eval "alias f$i='f $i'"
done
