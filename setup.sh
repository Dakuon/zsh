#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
COMMAND="exec zsh"

PROGS="zsh git wget python3"

if [ "$(uname -s)" == "Linux" ]; then
  PROGS="$PROGS gawk"
fi

if [[ "$(uname -s)" == "Darwin" && ! $commands[gls] ]]; then
  echo "OPT: Install coreutils to colorise file/dir with ls"
fi

if [ ! $commands[grc] ]; then
  echo "OPT: Install GRC to colorise ls"
fi

if [[ $commands[kubectl] && ! $commands[jq] ]]; then
  echo "OPT: Install jq to enable ksview completion"
fi


check_deps () {
  echo Checking for dependencies
  for PROG in $PROGS; do
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
  if [ $(basename -- $SHELL) != "zsh" ]; then
    echo;
    echo "#################################################"
    echo "# Changing shell, you might get password prompt #"
    echo "#################################################"
    chsh -s $(which zsh)
    echo;
  fi
fi

eval $COMMANDENV $COMMAND
