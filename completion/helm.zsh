if [[ ! -f ~/.completion/helm.zsh || ${COMP_UPDATE} ]]; then
  helm completion zsh > ~/.completion/helm.zsh
fi

source ~/.completion/helm.zsh
