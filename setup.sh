#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

for PROG in zsh git wget grc; do
    if ! $(which ${PROG} >/dev/null 2>&1); then
        echo Missing ${PROG^^}, install and restart script
        exit 1
    fi
done

if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    echo --------------------------------------------------------------------------
    echo Installing oh-my-zsh
    echo --------------------------------------------------------------------------
    sh -c "$(wget -qq -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
fi

for DIR in themes plugins; do
    if [ ! -d "${HOME}/.oh-my-zsh/${DIR}" ]; then
        mkdir ${HOME}.oh-my-zsh/${DIR}
    fi
done

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo --------------------------------------------------------------------------
    echo Cloning Powerlevel10K
    echo --------------------------------------------------------------------------
    cd $HOME/.oh-my-zsh/custom/themes
    git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git
fi

cd $HOME/.oh-my-zsh/custom/plugins

for PLUGIN in trapd00r/zsh-syntax-highlighting-filetypes zsh-users/zsh-autosuggestions; do
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/$(echo ${PLUGIN} | awk -F '/' '{print $2}')" ]; then
        echo --------------------------------------------------------------------------
        echo Cloning ${PLUGIN}
        echo --------------------------------------------------------------------------
        git clone -q https://github.com/${PLUGIN}.git
    else
        echo --------------------------------------------------------------------------
        echo Pulling ${PLUGIN} latest
        echo --------------------------------------------------------------------------
        cd $(echo ${PLUGIN} | awk -F '/' '{print $2}')
        git pull
        cd ..
    fi
done

ln -sf $BASE_DIR/configs/.zshrc $HOME/.zshrc
ln -sf $BASE_DIR/configs/.lscolors $HOME/.lscolors
ln -sf $BASE_DIR/configs/.lsregex $HOME/.lsregex
