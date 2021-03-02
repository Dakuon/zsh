if [[ ! -f ~/.completion/_aws-vault || ${COMP_UPDATE} ]]; then
  aws-vault --completion-script-zsh > ~/.completion/_aws-vault
fi

alias av=aws-vault
