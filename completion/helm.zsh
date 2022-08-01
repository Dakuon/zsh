if [[ ! -f ~/.completion/_helm || "$(which helm)" -nt ~/.completion/_helm ]]; then
  helm completion zsh > ~/.completion/_helm
fi
