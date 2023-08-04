if [[ ! -f ~/.completion/_aws-vault || "$(which aws-vault)" -nt ~/.completion/_aws-vault ]]; then
  aws-vault --completion-script-zsh > ~/.completion/_aws-vault
fi

export AWS_CLI_AUTO_PROMPT=on
alias av=aws-vault
