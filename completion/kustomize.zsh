if [[ ! -f ~/.completion/_kustomize || ${COMP_UPDATE} ]]; then
  kustomize completion zsh > /usr/share/zsh/functions/Completion/Linux/_kustomize
fi

alias kz=kustomize
