# auto-title
cd()    { __zsh_like_cd cd    "$@" && tab_title; }
pushd() { __zsh_like_cd pushd "$@" && tab_title; }
popd()  { __zsh_like_cd popd  "$@" && tab_title; }
tab_title
