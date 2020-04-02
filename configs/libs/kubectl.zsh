# Kubectl autocompletion
if [ $commands[kubectl] ]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
  # Install kubectl-krew if missing
  if [ ! -d "${HOME}/.krew" ]; then
    echo Installing kubectl krew
    cd "$(mktemp -d)"
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}"
    tar -zxf krew.tar.gz
    KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64"
    "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz 2> /dev/null
    "$KREW" update 2> /dev/null
    cd ${HOME}
  fi
  # Install plugins
  for PLUGIN in kubectl-ctx kubectl-ns kubectl-konfig; do
    if [ ! -f "${HOME}/.krew/bin/${PLUGIN}" ]; then
      echo Installing ${PLUGIN}
      kubectl krew install $(echo $PLUGIN | cut -d '-' -f2) 2> /dev/null
    fi
  done
  # Set up commands
  alias k=kubectl
  alias kns=${HOME}/.krew/bin/kubectl-ns
  alias kctx=${HOME}/.krew/bin/kubectl-ctx
  source <(k completion zsh)
  source ${HOME}/.zsh/configs/completion/kubens.bash
  source ${HOME}/.zsh/configs/completion/kubectx.bash
fi
