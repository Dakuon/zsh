function _update_zsh {
  echo "Checking github.com/dakuon/zsh for updates"
  # Update .zsh repo
  cd ${HOME}/.zsh
  local LOCAL_HASH=$(git rev-parse HEAD)
  local REFS=$(git symbolic-ref HEAD)
  local REMOTE_HASH=$(git ls-remote origin -h "${REFS}" | awk '{print $1}')
  
  if [ "${LOCAL_HASH}" != "${REMOTE_HASH}" ]; then
    echo "Pulling .zsh repo"
    git pull
    echo "Done with update. Restart your terminal for changes to take effect."
  fi
  cd - >/dev/null

  echo "Checking zimfw for updates"
  # Update zimfw
  if [ -n "$(zimfw check-version 2>&1)" ]; then
    echo "Updating zimfw"
    zimfw upgrade
  fi

  echo "Checking for missing zimfw plugins"
  # Install missing plugins
  if [ -n "$(zimfw list 2>&1 >/dev/null)" ]; then
    echo "Installing missing plugins"
    zimfw install
  fi

  echo "Checking for outdated zimfw plugins"
  # Update outdated plugins
  if [ -n "$(zimfw check 2>&1)" ]; then
    echo "Update plugins"
    zimfw update
  fi
}
