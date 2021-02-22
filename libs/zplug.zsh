zplug_install () {
  if [[ $LANG != *"."* ]]; then
    export LANG=${LANG}.UTF-8
  fi

  if [[ $LC_ALL != *"."* ]]; then
    export LC_ALL=${LC_ALL}.UTF-8
  fi

  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

if [ ! -d ~/.zplug ]; then
  zplug_install
fi

# Load zplug
if [ -f "${HOME}/.zplug/init.zsh" ]; then
  source ~/.zplug/init.zsh
else
  until zplug info >/dev/null 2>&1; do
    if [ $? != 127 ]; then
      cd ~/.zplug
      git apply --check ~/.zsh/patches/zplug-pr474.patch >/dev/null 2>&1
      if [ $? == 0 ]; then
        git apply ~/.zsh/patches/zplug-pr474.patch
        source ~/.zplug/init.zsh
      fi
      echo;
      cd;
      break
    fi
    source ~/.zplug/init.zsh >/dev/null 2>&1
    sleep 0.1
  done
fi
