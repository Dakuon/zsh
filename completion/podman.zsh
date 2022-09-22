if [[ ! -f ~/.completion/_podman || "$(which podman)" -nt ~/.completion/_podman ]]; then
  podman completion zsh > ~/.completion/_podman
fi

alias docker=podman
