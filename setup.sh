#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo Checking for dependencies
for PROG in zsh git wget grc python3 jq; do
  if ! $(which ${PROG} >/dev/null 2>&1); then
    echo Missing ${PROG^}
    MISSING=1
  else
    echo Found ${PROG^}
  fi
done

if [[ -n ${MISSING} ]]; then
  echo Install dependencies and restart script
  exit 1
fi

ln -sf $BASE_DIR/dotfiles/.zshrc $HOME/.zshrc

exec zsh
