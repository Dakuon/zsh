if [[ ! -f ~/.completion/_kubectl || ${COMP_UPDATE} ]]; then
  kubectl completion zsh > ~/.completion/_kubectl
fi
