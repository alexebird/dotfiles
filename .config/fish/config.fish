set PATH "/usr/local/opt/coreutils/libexec/gnubin" $PATH
set PATH "/usr/local/opt/gnu-tar/libexec/gnubin" $PATH
set PATH "/usr/local/opt/gnu-sed/libexec/gnubin" $PATH
set PATH ~/bin $PATH
set PATH bin $PATH

set MANPATH "/usr/local/opt/coreutils/libexec/gnuman" $MANPATH
set MANPATH "/usr/local/opt/gnu-sed/libexec/gnuman" $MANPATH

set -x RUBYLIB lib $RUBYLIB

set -g -x fish_greeting ''

rvm use ruby > /dev/null

