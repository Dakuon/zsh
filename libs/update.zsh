function _update_zsh {
  CDIR=$(pwd)
  cd ${HOME}/.zsh
  git pull
  cd ${CDIR}
  unset CDIR
}
