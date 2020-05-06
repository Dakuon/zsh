# Kubectl autocompletion
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Install kubectl-krew if missing
if [ ! -d "${HOME}/.krew" ]; then
  echo Installing kubectl-krew
  cd "$(mktemp -d)"
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}"
  tar -zxf krew.tar.gz
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64"
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz 2> /dev/null
  "$KREW" update 2> /dev/null
  cd ${HOME}
fi

for PLUGIN in ctx ns konfig view-secret; do
  install=true
  for INSTALLED in $(kubectl krew list | grep -v PLUGIN); do
    if [[ $PLUGIN == $INSTALLED ]]; then
      install=false
      continue
    fi
  done
  if $install; then
    echo Installing kubectl-${PLUGIN}
    kubectl krew install $PLUGIN 2> /dev/null
  fi
done

# Set up commands
alias k=kubectl
alias kkrew=${HOME}/.krew/bin/kubectl-krew
alias kns=${HOME}/.krew/bin/kubectl-ns
alias kctx=${HOME}/.krew/bin/kubectl-ctx
alias ksview=${HOME}/.krew/bin/kubectl-view_secret
source ${HOME}/.zsh/completion/kubectl.zsh
source ${HOME}/.zsh/completion/kubens.zsh
source ${HOME}/.zsh/completion/kubectx.zsh
source ${HOME}/.zsh/completion/kubesecret.zsh
