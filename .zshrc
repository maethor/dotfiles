#!/bin/zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias g="gotcha -r"
alias halt='poweroff'

alias gs='git status'
compdef _git gs=git-status

[[ -x /usr/bin/pydf ]] && alias df="pydf -h"

export TEXMFHOME="$HOME/.texmf"
export PATH="$PATH:$HOME/.bin:$HOME/.local/bin"
export WORKON_HOME="$HOME/.envs"
export PROJECT_HOME="$HOME/Programmes/Work"
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
export PIP_VIRTUALENV_BASE=$WORKON_HOME

# full name
NAME="Guillaume Subiron"
DEBFULLNAME=$NAME

# email address
export EMAIL="maethor@subiron.org"
export DEBEMAIL=$EMAIL

# email address for anonymous ftp
export EMAIL_ADDR=plop@dev.null

# checking events on system (users login/logout, etc...)
watch=(notme)
LOGCHECK=5
WATCHFMT="[%T] %n has %a %l from %M"

# override default umask
umask 0022
