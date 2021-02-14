if [[ ! -f ~/.completion/fly.zsh || ${COMP_UPDATE} ]]; then
  fly completion --shell zsh > ~/.completion/fly.zsh
fi

source ~/.completion/fly.zsh
