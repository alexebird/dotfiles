#!/bin/bash

_gpg_role_path() {
  echo "./gpg/roles/${1:-}"
}

_gpg_pub_key_path() {
  echo "./gpg/public/${1:-}"
}

_gpg_ls_roles() {
  find "$(_gpg_role_path)" -type f -printf '%f\n'
}

_gpg_is_role() {
  _gpg_ls_roles | grep -q "${1}"
}

_gpg_match_pub_key() {
  local thing="${1}"
  find "$(_gpg_pub_key_path)" -type f -printf '%f\n' | grep -q "${thing}"
}

_gpg_flatten_role_helper() {
  local role="${1:?must pass role}"

  if ! _gpg_is_role "${role}"; then
    >&2 echo "couldn't find role: ${role}"
    return 1
  fi

  local role_contents="$(cat "$(_gpg_role_path "${role}")")"

  for e in ${role_contents}; do
    if _gpg_is_role "${e}"; then
      _gpg_flatten_role_helper "${e}"
    elif _gpg_match_pub_key "${e}"; then
      echo "${e}" | sed -n -e's/.*id:\([0-9A-Z]\+\).*/\1/p'
    else
      >&2 echo "${e} is not a role or public key"
    fi
  done
}

_gpg_flatten_role() {
  _gpg_flatten_role_helper "${1}"
}

_join() {
  local joint="${1:-}"
  shift
  local i=0
  for e in "$@"; do
    echo -n "${e}"
    ((i++))
    if [[ "${i}" != "$#" ]]; then
      echo -n "${joint}"
    else
      echo
    fi
  done
}

_gpg_recipients_list() {
  local role="${1}"
  local recips="$(_gpg_flatten_role "${role}")"
  if [[ -n "${recips}" ]]; then
    echo "-r $(_join ' -r ' ${recips})"
  else
    return 1
  fi
}

_gpg_roles_completer() {
  _gpg_ls_roles
  echo
}

complete -F _gpg_roles_completer _gpg_recipients_list
