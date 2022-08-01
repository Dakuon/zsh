if [[ ! -f ~/.completion/_kustomize || "$(which kustomize)" -nt ~/.completion/_kustomize ]]; then
  kustomize completion zsh > ~/.completion/_kustomize
fi

alias kz=kustomize
