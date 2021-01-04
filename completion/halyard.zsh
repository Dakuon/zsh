if [ ! -f ~/.completion/hal.zsh || ${COMP_UPDATE} ]; then
  hal --print-bash-completion > ~/.completion/hal.zsh
fi

source ~/.completion/hal.zsh
