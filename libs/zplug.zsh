# zplug-install/use fails if locale is set without .UTF-8
if [[ "${LANG}" == *".UTF-8" ]]; then
  ZLANG="${LANG}"
else
  ZLANG="en_US.UTF-8"
fi

if [ ! -d ~/.zplug ]; then
  wget -qO- https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | LANG="${ZLANG}" zsh
  sleep 3
fi

# Load zplug
source ~/.zplug/init.zsh
# Fix zplug-command issue with LANG settings
alias zplug="LANG=${ZLANG} zplug"
