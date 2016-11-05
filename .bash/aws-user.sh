function aws-user() {
  eval "$(gpg -d ${HOME}/.aws-users/${1}.sh.gpg)"
}
