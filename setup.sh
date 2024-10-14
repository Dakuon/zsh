#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
COMMAND="exec zsh"

PROGS="zsh git wget python3"

if [ "$(uname -s)" == "Linux" ]; then
  PROGS="$PROGS gawk"
fi

if [ ! -d "${HOME}/.config/lsd" ]; then
  mkdir -p "${HOME}/.config/lsd"
fi

check_deps () {
  echo Checking for dependencies
  for PROG in $PROGS; do
    if ! which "${PROG}" >/dev/null 2>&1; then
      echo "Missing ${PROG}"
      MISSING=1
    else
      echo "Found ${PROG}"
    fi
  done

  if [[ -n ${MISSING} ]]; then
    echo Install dependencies and restart script
    exit 1
  fi
}

symlink () {
  ln -sf "${BASE_DIR}/configs/.zshrc" "${HOME}/.zshrc"
  ln -sf "${BASE_DIR}/configs/.zimrc" "${HOME}/.zimrc"
  if [[ -d "${HOME}/.config/lsd" && ! -f "${HOME}/.config/lsd/config.yaml" ]]; then
    ln -sf "${BASE_DIR}/configs/lsd-config.yaml" "${HOME}/.config/lsd/config.yaml"
    ln -sf "${BASE_DIR}/configs/lsd-colors.yaml" "${HOME}/.config/lsd/colors.yaml"
  fi
}

for arg in "$@"; do
  case $arg in
    -h|--help)
      echo "-a|--auto       - Install without prompts"
      echo "-u|--unattended - For scripted installers"
      echo "-z|--zsh-shell  - Set ZSH as default shell"
      exit
      ;;
    -a|--auto)
      COMMANDENV="INST=true"
      ;;
    -u|--unattended)
      COMMAND="${HOME}/.zsh/configs/.unattended.sh"
      ;;
    -z|--zsh-shell)
      SETSHELL=true
      ;;
    *)
      echo "Use --help to list supported options"
      exit
      ;;
  esac
done

check_deps
symlink

if [[ -n $SETSHELL ]]; then
  if [ "$(basename -- "$SHELL")" != "zsh" ]; then
    echo;
    echo "#################################################"
    echo "# Changing shell, you might get password prompt #"
    echo "#################################################"
    chsh -s "$(which zsh)"
    echo;
  fi
fi

eval ${COMMANDENV} "${COMMAND}"
