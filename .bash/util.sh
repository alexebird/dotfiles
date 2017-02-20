#!/bin/bash

alias dp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Names}}"'
alias dpp='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias wdp="watch -n1 'docker ps --format \"table {{.ID}}\t{{.Status}}\t{{.Names}}\"'"
alias urlencode='python -c "import urllib, sys; print urllib.quote(sys.argv[1])"'
alias urldecode='python -c "import urllib, sys; print urllib.unquote(sys.argv[1])"'
alias genpass="tr -dc '_%#$@&*^!A-Za-z0-9' < /dev/urandom | head -c20; echo"

if ! uname -a | grep -q Darwin ; then
  alias open='xdg-open'
else
  alias copy='pbcopy'
  alias paste='pbpaste'
fi

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

search-and-replace() {
  local pattern="$1"
  local from="$2"
  local to="$3"
  find . -type d -name .git -prune -o -type f -name "${pattern}" -print -exec sed -i -e"s/${from}/${to}/g" {} \;
}

google() {
  local query=$(python -c "import urllib, sys; print urllib.quote(sys.argv[1])" "$*")
  google-chrome https://www.google.com/search?q=${query}
}

whereisfunc() {
  shopt -s extdebug ; declare -F "$1" ; shopt -s extdebug
}
