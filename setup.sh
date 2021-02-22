#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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
      echo "-u|--unattended - For scripted installers"
      echo "-a|--auto       - Install without prompts"
      exit
      ;;
    -u|--unattended)
      check_deps
      symlink
      INST=true zsh -i -c exit
      exit
      ;;
    -a|--auto)
      check_deps
      symlink
      INST=true AUTO=true exec zsh
      ;;
    *)
      echo "Use --help to list supported options"
      exit
      ;;
  esac
done

if [ "$#" -lt 1 ]; then
  check_deps
  symlink
  exec zsh
fi
