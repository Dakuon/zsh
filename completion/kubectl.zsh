if [[ ! -f ~/.completion/kubectl.zsh || ${COMP_UPDATE} ]]; then
  kubectl completion zsh > ~/.completion/kubectl.zsh
fi

source ~/.completion/kubectl.zsh

