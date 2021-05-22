# Kubectl autocompletion

# Add ~/.krew/bin to path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Remove skip-file
remove_skip () {
  if [ -f ~/.skip_krew ]; then
    rm ~/.skip_krew
  fi
}

# Install kubectl-krew
install_krew () {
  cd "$(mktemp -d)"
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}"
  tar -zxf krew.tar.gz
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64"
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz 2> /dev/null
  "$KREW" update 2> /dev/null
  cd ~
}

# Install plugins
install_plugins () {
  for PLUGIN in ctx ns konfig view-secret neat; do
    install=true
    for INSTALLED in $(kubectl krew list | grep -v PLUGIN); do
      if [[ ${PLUGIN} == ${INSTALLED} ]]; then
        install=false
        continue
      fi
    done
    if $install; then
      echo "Installing kubectl-${PLUGIN}"
      kubectl krew install ${PLUGIN} 2> /dev/null
    fi
  done
}

# Install kubectl-krew if missing
if [[ ! -d ~/.krew && ! -f ~/.skip_krew || ${KUBE_UPDATE} || ${INST} ]]; then
  echo;
  if [ ! $commands[kubectl-krew] ]; then
    if [ -z ${INST} ]; then
      printf "Install kubectl-krew and plugins? [y/N]: "
      if read -q; then
        echo; echo "Installing kubectl-krew"
        install_krew
        install_plugins
        remove_skip
      else
        touch ~/.skip_krew
        echo; echo "Run update-kubectl or delete ~/.skip_krew and reload zsh to install"
      fi
    else
      echo "Installing kubectl-krew"
      install_krew
      install_plugins
      remove_skip
    fi
  else
    echo "Updating plugins"
    kubectl-krew upgrade
  fi
fi

# Set up commands
alias k=kubectl
alias kkrew=~/.krew/bin/kubectl-krew
alias kns=~/.krew/bin/kubectl-ns
alias kctx=~/.krew/bin/kubectl-ctx
alias ksview=~/.krew/bin/kubectl-view_secret

source ~/.zsh/completion/kubectl.zsh
source ~/.zsh/completion/kubens.zsh
source ~/.zsh/completion/kubectx.zsh
if [ $commands[jq] ]; then
  source ~/.zsh/completion/kubesecret.zsh
fi
