#!/bin/zsh

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"

source "${ZDOTDIR:-$HOME}/.zlong_alert.zsh"
zlong_duration=30
zlong_ignore_cmds="vim ssh neomutt most tmux ansible su pipenv"

unsetopt BEEP

bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

alias g="gotcha -r"
alias d="date +%Y-%m-%d"
alias h="[ -f /etc/hostname.sysnove ] && cat /etc/hostname.sysnove || hostname"

bm () {
    if [ -n "$(sudo ls /mnt)" ]; then
        echo "/mnt is not empty"
        return 1
    fi
    export BORG_RELOCATED_REPO_ACCESS_IS_OK=yes
    export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=yes
    if [ -n "$1" ]; then
        date="$1"
    else
        date=$(sudo jq -r '.archives[0].name' /var/backups/borginfo.json)
    fi
    backup="backups:$(h)::$date"
    echo "Mounting $backup in /mnt…"
    sudo borg mount "$backup" /mnt
    echo "Done."
}

alias gs='git status'
compdef _git gs=git-status

alias mutt='neomutt'

alias ack='ack --follow'

alias ansible='noglob ansible'
alias ansible-playbook='noglob ansible-playbook'

[[ -x /usr/bin/pydf ]] && alias df="pydf -h"
#[[ -x /usr/bin/batcat ]] && alias bat="batcat --style=plain,grid --paging=never" && alias cat="bat"

[[ -x /usr/bin/nvim ]] && alias vim="nvim"
[[ -x $HOME/.bin/nvim ]] && alias vim="$HOME/.bin/nvim"

function python () {
    test -z "$1" && ipython || command python "$@"
}

function python3 () {
    test -z "$1" && ipython3 || command python3 "$@"
}

unsetopt CORRECT

export TEXMFHOME="$HOME/.texmf"
export PATH="$PATH:$HOME/.bin:$HOME/.local/bin"
export WORKON_HOME="$HOME/.envs"
export PROJECT_HOME="$HOME/Programmes/Work"
export PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"
export PIP_VIRTUALENV_BASE=$WORKON_HOME

pyenv () {
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$($PYENV_ROOT/bin/pyenv init -)"
    eval "$($PYENV_ROOT/bin/pyenv virtualenv-init -)"
    $PYENV_ROOT/bin/pyenv "$@"
}

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

#if [[ -e /usr/share/doc/fzf/examples/completion.zsh ]]; then
#    source /usr/share/doc/fzf/examples/completion.zsh
#    source /usr/share/doc/fzf/examples/key-bindings.zsh
#    bindkey '^R' history-incremental-search-backward
#    export FZF_DEFAULT_OPTS='--preview "batcat --style=numbers --color=always {} | head -500"'
#fi

# History cleanup
function smite() {
    setopt LOCAL_OPTIONS ERR_RETURN PIPE_FAIL

    local opts=( -I )
    if [[ $1 == '-a' ]]; then
        opts=()
    elif [[ -n $1 ]]; then
        print >&2 'usage: smite [-a]'
        return 1
    fi

    fc -l -n $opts 1 | \
        fzf --no-sort --tac --multi | \
        while IFS='' read -r command_to_delete; do
            printf 'Removing history entry "%s"\n' $command_to_delete
            local HISTORY_IGNORE="${(b)command_to_delete}"
            fc -W
            fc -p $HISTFILE $HISTSIZE $SAVEHIST
        done
}

# override default umask
umask 0022
