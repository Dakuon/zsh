###
# Parts taken from oh-my-zsh - https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
###

# Set correct ls-command
if [ "${commands[lsd]}" ]; then
  export _LS=(=lsd)
elif [[ "$OSTYPE" != "linux-gnu" && $commands[gls] ]]; then
  export _LS=(=gls)
else
  export _LS=(=ls)
fi

# Set aliases
alias l='$_LS -lh -F $@'
alias ll='$_LS -lh -FA $@'

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
