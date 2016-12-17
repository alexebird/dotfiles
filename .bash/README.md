DOTFILES
========

```bash
# in ~/.bashrc

export HISTCONTROL=erasedups
export HISTSIZE=
export HISTFILESIZE=
shopt -s histappend

export PATH="${HOME}/bin:${HOME}/.bash/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"

for f in /usr/local/etc/bash_completion.d/* ; do
  . "${f}"
done

[[ -s ~/.bash/colors.sh ]] && . ~/.bash/colors.sh
[[ -s ~/.bash/lib.sh ]] && . ~/.bash/lib.sh
[[ -s ~/.bash/util.sh ]] && . ~/.bash/util.sh
[[ -s ~/.bash/aliases.sh ]] && . ~/.bash/aliases.sh
```
