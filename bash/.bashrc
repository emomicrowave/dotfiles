#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'

alias termite='termite -c ~/.config/termite/config'
alias testcompile='g++ -o test -Wall -Wextra'

alias vim='nvim'

# variables export
export PATH=$PATH:$HOME/anaconda3/bin
export PATH=$PATH:~/.bin/
export PATH=$PATH:~/.cargo/bin
export RUST_SRC_PATH=$HOME/Developement/rust/rust-lang/src

# add prefered terminal as variable, so that CTRL+ALT+T opens it
export TERMINAL=/usr/bin/termite

PS1='[\u@\h \W]\$ '
# >>> BEGIN ADDED BY CNCHI INSTALLER
BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/vim
# <<< END ADDED BY CNCHI INSTALLER
