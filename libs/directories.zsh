###
# Taken from oh-my-zsh - https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
###

if [ $commands[grc] ]; then
  export _LS=(=ls)
  export _LS=($_LS -hF  --group-directories-first --time-style=+%d-%m-%Y\ %H:%M)
  export _GRC=("grc" "--config=$HOME/dotfiles/.lsregex")
  alias ls='$_GRC $_LS --color -C $@'
  alias l='$_GRC $_LS --color -la $@'
  alias la='$_GRC $_LS --color -C -A $@'
  alias ll='$_GRC $_LS --color -la $@'
fi

# set ls file/folder colors
if [ -f "${HOME}/.lscolors" ]; then
  eval `dircolors ${HOME}/dotfiles/.lscolors`
fi

# Changing/making/removing directory
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

alias md='mkdir -p'
alias rd=rmdir

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -10
  fi
}

compdef _dirs d
