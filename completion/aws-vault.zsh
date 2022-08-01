if [[ ! -f ~/.completion/_aws-vault || "$(which aws-vault)" -nt ~/.completion/_aws-vault ]]; then
  aws-vault --completion-script-zsh > ~/.completion/_aws-vault
fi

alias av=aws-vault
