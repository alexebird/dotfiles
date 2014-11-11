if test -f /usr/local/share/chruby/chruby.fish
	source /usr/local/share/chruby/chruby.fish
	source /usr/local/share/chruby/auto.fish
else if functions -q rvm
	rvm use ruby > /dev/null
end

# autojump
if test -f ~/.autojump/etc/profile.d/autojump.fish; . ~/.autojump/etc/profile.d/autojump.fish; end

# aliases
alias gb='git branch'
alias gci='git commit'
alias gco='git checkout'
alias gd='git diff'
alias git='hub'
alias gl='git lg'
alias gs='git status'

set PATH "/usr/local/opt/coreutils/libexec/gnubin" $PATH
set PATH "/usr/local/opt/gnu-tar/libexec/gnubin" $PATH
set PATH "/usr/local/opt/gnu-sed/libexec/gnubin" $PATH
set PATH ~/bin $PATH
set PATH bin $PATH

set MANPATH "/usr/local/opt/coreutils/libexec/gnuman" $MANPATH
set MANPATH "/usr/local/opt/gnu-sed/libexec/gnuman" $MANPATH

set -x RUBYLIB lib $RUBYLIB
set -x EDITOR vim

set -g -x fish_greeting ''

