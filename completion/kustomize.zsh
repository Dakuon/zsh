if [[ ! -f ~/.completion/_kustomize || ${COMP_UPDATE} ]]; then
  kustomize completion zsh > ~/.completion/_kustomize
fi

alias kz=kustomize
