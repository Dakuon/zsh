if [[ ! -f ~/.completion/_helm || ${COMP_UPDATE} ]]; then
  helm completion zsh > ~/.completion/_helm
fi
