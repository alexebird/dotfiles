alias genpass="tr -dc '_%#$@&*^!A-Za-z0-9' < /dev/urandom | head -c20; echo"
alias dp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Names}}"'
alias dpp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias wdp="watch -n1 'docker ps --format \"table {{.ID}}\t{{.Status}}\t{{.Names}}\"'"
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
alias ag='ag --hidden --smart-case'
#alias ctags-rb='ctags -R --languages=ruby --exclude=.git --exclude=log .'
alias ls='ls -F'
alias l='ls'
alias l1='ls -1'
alias ll='\ls -Fltrh'
alias la='\ls -FltrhA'
alias grep='grep --color=auto'
alias less='less -R'
alias urlencode='python -c "import urllib, sys; print urllib.quote(sys.argv[1])"'
alias urldecode='python -c "import urllib, sys; print urllib.unquote(sys.argv[1])"'
alias banner='figlet -f graffiti'
alias g='figlet -f doh G'
#alias docker-nodes="docker info | tail -n+6 | head -n-3 | grep -v '└' | tail -n+2"
alias ipz="jq -rC '.Reservations[].Instances | map(. | ((.NetworkInterfaces[].PrivateIpAddress), (.KeyName), (.Tags | from_entries | .Name))) | @tsv' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4"

if ! uname -a | grep -q Darwin ; then
  alias open='xdg-open'
else
  alias copy='pbcopy'
  alias paste='pbpaste'
fi

orphaned_local_branches() {
  local remotes=$(git branch -a | grep '  remotes' | sed -e's|  remotes/origin/||')
  for e in $(git branch | sed -e's/\(* \)\|\(  \)//') ; do
    echo "$remotes" | grep -q $e || echo "$e"
  done
}

hs() {
    history | grep -i "$*"
}

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
