function aws-env() {
  eval "$(gpg -d ${HOME}/.davinci/${1}.sh.gpg)"
}

function do-env() {
  eval "$(gpg -d ${HOME}/.davinci/${1}.sh.gpg)"
}
