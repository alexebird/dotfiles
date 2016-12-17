alias genpass="tr -dc '_%#$@&*^!A-Za-z0-9' < /dev/urandom | head -c20; echo"
alias dp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Names}}"'
alias dpp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias wdp="watch -n1 'docker ps --format \"table {{.ID}}\t{{.Status}}\t{{.Names}}\"'"

hs() {
    history | grep -i "$*"
}

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

alias ag='ag --hidden --smart-case'
#alias ctags-rb='ctags -R --languages=ruby --exclude=.git --exclude=log .'

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

# less
alias less='less -R'

# urls
alias urlencode='python -c "import urllib, sys; print urllib.quote(sys.argv[1])"'
alias urldecode='python -c "import urllib, sys; print urllib.unquote(sys.argv[1])"'

# fun
#alias upgrade='sudo apt-get -y update && sudo apt-get -y dist-upgrade'
#alias shit='ssh it'
#alias rbj='ruby -rawesome_print -rjson -e'
#alias ddd='gpg -d'
#alias rr='reset'
#alias pssh="ps -eo pid,args | grep ssh | grep -v 'grep\|sshd\|ssh-agent'"
#alias myip="ifconfig eth2 | grep -o --color=none '10\.\0\.20\.[[:digit:]]\+'"
alias banner='figlet -f graffiti'
#alias enable-pointer='xinput set-prop 13 "Device Enabled" 1'
#alias disable-pointer='xinput set-prop 13 "Device Enabled" 0'
#alias enable-touchpad='xinput set-prop 12 "Device Enabled" 1'
#alias disable-touchpad='xinput set-prop 12 "Device Enabled" 0'
#alias bat='for i in 0 1; do echo BAT$i ; upower -i "/org/freedesktop/UPower/devices/battery_BAT${i}" | grep --color=never "time to empty" ; done'
alias g='figlet -f doh G'

# docker
#alias docker-nodes="docker info | tail -n+6 | head -n-3 | grep -v '└' | tail -n+2"

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

whereisfunc() {
  shopt -s extdebug ; declare -F "$1" ; shopt -s extdebug
}

name-branch() {
  paste | ruby -e'puts STDIN.read.gsub(/[\s_]+/, "-").downcase'
}

alias ipz="jq -rC '.Reservations[].Instances | map(. | ((.NetworkInterfaces[].PrivateIpAddress), (.KeyName), (.Tags | from_entries | .Name))) | @tsv' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4"
