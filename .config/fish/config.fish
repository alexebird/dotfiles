if test -f ~/src/chruby-fish/share/chruby/chruby.fish
	source ~/src/chruby-fish/share/chruby/chruby.fish
	source ~/src/chruby-fish/share/chruby/auto.fish
	chruby ruby-2.1
else if functions -q rvm
	rvm use ruby > /dev/null
end

set PATH "/usr/local/opt/coreutils/libexec/gnubin" $PATH
set PATH "/usr/local/opt/gnu-tar/libexec/gnubin" $PATH
set PATH "/usr/local/opt/gnu-sed/libexec/gnubin" $PATH
set PATH ~/bin $PATH
set PATH bin $PATH

set MANPATH "/usr/local/opt/coreutils/libexec/gnuman" $MANPATH
set MANPATH "/usr/local/opt/gnu-sed/libexec/gnuman" $MANPATH

set -x RUBYLIB lib $RUBYLIB

set -g -x fish_greeting ''

