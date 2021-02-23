zplug_install () {
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

zplug_patch () {
  cd ~/.zplug
  git apply --check ~/.zsh/patches/zplug-pr474.patch
  if [ $? == 0 ]; then
    git apply ~/.zsh/patches/zplug-pr474.patch
  fi
  echo;
  cd;
}

# Install zplug and patch it
if [ ! -d "${HOME}/.zplug" ]; then
  zplug_install
  until ls ${HOME}/.zplug/base/job/handle.zsh >/dev/null 2>&1; do
    sleep 0.1
  done
  zplug_patch
fi

# Load zplug
until zplug info >/dev/null 2>&1; do
  if [ $? != 127 ]; then
    break
  fi
  source ~/.zplug/init.zsh >/dev/null 2>&1
  sleep 0.1
done