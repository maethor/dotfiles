# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="maethor"

# CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian)

source $ZSH/oh-my-zsh.sh

source $HOME/.zshrc.d/maethor.zsh-theme

export GREP_COLOR=''

if [ -d $HOME/.zshrc.d ]
then for zshrc_file in `/bin/run-parts --test $HOME/.zshrc.d`
    do source $zshrc_file
    done
unset zshrc_file
fi

