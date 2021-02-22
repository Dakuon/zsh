#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
COMMAND="exec zsh"

check_deps () {
  echo Checking for dependencies
  for PROG in zsh git wget grc python3 jq gawk; do
    if ! $(which ${PROG} >/dev/null 2>&1); then
      echo Missing ${PROG}
      MISSING=1
    else
      echo Found ${PROG}
    fi
  done

  if [[ -n ${MISSING} ]]; then
    echo Install dependencies and restart script
    exit 1
  fi
}

symlink () {
  ln -sf $BASE_DIR/dotfiles/.zshrc $HOME/.zshrc
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
      COMMAND="zsh -i -c exit"
      COMMANDENV="INST=true"
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

if [[ ! -z $SETSHELL ]]; then
  echo;
  echo "#################################################"
  echo "# Changing shell, you might get password prompt #"
  echo "#################################################"
  chsh -s $(which zsh)
  echo;
fi

eval $COMMANDENV $COMMAND
