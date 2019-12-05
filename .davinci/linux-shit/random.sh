#gpg_agent_start() {
  #if [[ $(ps -ef | grep gpg-agent | grep -v grep) ]]; then
    #export GPG_AGENT_INFO="$(find /tmp -type s -name 'S.gpg-agent' 2> /dev/null):$(ps -ef | grep gpg-agent | grep -v grep | awk '{print $2}'):1"
  #fi
#}

#unswap_alt_super() {
  #setxkbmap -layout us -option ''
#}

#swap_alt_super() {
  #setxkbmap -option altwin:swap_alt_win
#}

#fix_caps_lock() {
  #setxkbmap -layout us -option ''
#}
