if [[ ! -f ~/.completion/_kubectl || "$(which kubectl)" -nt ~/.completion/_kubectl ]]; then
  kubectl completion zsh > ~/.completion/_kubectl
fi
