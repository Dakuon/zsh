###
# Parts taken from oh-my-zsh - https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
###

# Set correct ls-command
if [[ "$OSTYPE" != "linux-gnu" && $commands[gls] ]]; then
  export _LS=(=gls)
  alias dircolors="gdircolors"
else
  export _LS=(=ls)
fi

# Set GRC command
if [ $commands[grc] ]; then
  export _GRC=("grc" "--config=${HOME}/.zsh/dotfiles/.lsregex")
fi

$_LS --time-style="+%d-%m-%Y %H:%M" > /dev/null 2>&1
if [ $? == 0 ]; then
  export LS_ARGS=("--time-style=+%d-%m-%Y %H:%M")
fi

# Set ls args if supported
$_LS --color > /dev/null 2>&1
if [ $? == 0 ]; then
  export LS_ARGS=(${LS_ARGS} "--color")
fi

# Set ls args if supported
$_LS --group-directories-first > /dev/null 2>&1
if [ $? == 0 ]; then
  export LS_ARGS=(${LS_ARGS} "--group-directories-first")
fi

# Set ls file/folder colors
if [[ $commands[dircolors] || $commands[gdircolors] ]]; then
  eval "$(dircolors ${HOME}/.zsh/dotfiles/.lscolors)"
fi

# Set aliases
alias ls='$_GRC $_LS $LS_ARGS -C $@'
alias l='$_GRC $_LS $LS_ARGS -lh -F $@'
alias lx='$_GRC $_LS $LS_ARGS -lh -F -X $@'
alias la='$_GRC $_LS $LS_ARGS -C -A $@'
alias ll='$_GRC $_LS $LS_ARGS -lh -FA $@'
alias llx='$_GRC $_LS $LS_ARGS -lh -FA -X $@'

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
