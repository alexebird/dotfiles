BIRD'S DOTFILES
===============

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

LUBUNTU
=======

Caps-Lock remap
---

```
# in ~/.profile, after sourcing bashrc

setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
```

Digital Clock
----

```
%a %b %d %I:%M:%S %p
```

Swoop
-----

In ~/.config/openbox/lubuntu-rc.xml:

```
    <!-- custom - windows-s -->
    <keybind key="W-s">
      <action name="Execute">
        <command>bash /home/bird/bin/swoop.sh</command>
      </action>
    </keybind>
    <!-- /custom -->
```

You may need to edit swoop.sh to have the correct resolution for the monitor.

MACOS
=====

- compiled neovim from source to get clipboard functionality

keyboard/mouse
---

```
defaults write .GlobalPreferences com.apple.mouse.scaling -1
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 0 # normal minimum is 2 (30 ms)
```

gnu tools, coreutils
---
- install gnu tools https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
```
brew install coreutils
brew install binutils
brew install diffutils
brew install ed
brew install findutils
brew install gawk
brew install gnu-indent
brew install gnu-sed
brew install gnu-tar
brew install gnu-which
brew install gnutls
brew install grep
brew install gzip
brew install screen
brew install watch
brew install wdiff
brew install wget
brew install less
```
