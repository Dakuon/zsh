zplug_install () {
  local LC_ALL=en_US.UTF-8

  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

if [ ! -d ~/.zplug ]; then
  zplug_install
fi

# Load zplug
if [ -f "~/.zplug/init.zsh" ]; then
  source ~/.zplug/init.zsh
else
  until zplug info >/dev/null 2>&1; do
    if [ $? != 127 ]; then
      cd ~/.zplug
      git apply --check ~/.zsh/patches/zplug-pr474.patch
      if [ $? == 0 ]; then
        git apply ~/.zsh/patches/zplug-pr474.patch
        source ~/.zplug/init.zsh
      fi
      break
    fi
    source ~/.zplug/init.zsh >/dev/null 2>&1
    sleep 0.1
  done
fi
