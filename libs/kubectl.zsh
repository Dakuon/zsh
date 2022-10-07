# Kubectl autocompletion

# Add ~/.krew/bin to path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Plugins
PLUGINS=(ctx ns konfig view-secret neat images df-pv iexec)

# Remove skip-file
remove_skip () {
  if [ -f ~/.skip_krew ]; then
    rm ~/.skip_krew
  fi
}

# Install kubectl-krew
install_krew () {
  cd "$(mktemp -d)"
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
  KREW="krew-${OS}_${ARCH}"
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"
  tar zxf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew 2> /dev/null
  "$KREW" update 2> /dev/null
  cd ~
}

# Install plugins
install_plugins () {
  INSTALLED_PLUGINS=($(kubectl krew list | tail -n+1))
  for PLUGIN in ${PLUGINS[*]}; do
    if [[ ! "${INSTALLED_PLUGINS[*]}" =~ "${PLUGIN}" ]]; then
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
    echo "Installing/Updating plugins"
    install_plugins
    kubectl-krew upgrade
  fi
fi

# Set up commands

# kubectl-krew
alias kkrew=~/.krew/bin/kubectl-krew

# kubectl
source ~/.zsh/completion/kubectl.zsh
if [ $commands[kubecolor] ]; then
  compdef kubecolor=kubectl
  export _KUBECTL=(=kubecolor)
  alias k=kubecolor
else
  export _KUBECTL=(=kubectl)
  alias k=kubectl
fi

# kubectl-ns
source ~/.zsh/completion/kubens.zsh
alias kns=~/.krew/bin/kubectl-ns

# kubectl-ctx
source ~/.zsh/completion/kubectx.zsh
alias kctx=~/.krew/bin/kubectl-ctx

# kubectl-secret_view
if [ $commands[jq] ]; then
  source ~/.zsh/completion/kubesecret.zsh
  alias ksview=~/.krew/bin/kubectl-view_secret
fi

# kubectl-neat
alias kn=~/.krew/bin/kubectl-neat

alias kg='$_KUBECTL get -owide'
alias kgy='$_KUBECTL get -oyaml $@'
alias kd='$_KUBECTL describe'
alias ka='$_KUBECTL apply -f $@'
alias kak='$_KUBECTL apply -k $@'
alias krm='$_KUBECTL delete'

alias kgp='$_KUBECTL get pods -owide'
alias kgpy='$_KUBECTL get pods -oyaml'
alias kdp='$_KUBECTL describe pod'
alias ktp='$_KUBECTL top pods'

alias kgn='$_KUBECTL get node -owide'
alias kgny='$_KUBECTL get node -oyaml'
alias kdn='$_KUBECTL describe node'
alias ktn='$_KUBECTL top node'

alias kgsvc='$_KUBECTL get svc -owide'
alias kgsvcy='$_KUBECTL get svc -oyaml'
alias kdsvc='$_KUBECTL describe svc'

alias kgns='$_KUBECTL get ns'
alias kgnsy='$_KUBECTL get nsy -oyaml'
alias kdns='$_KUBECTL describe ns'

alias kgsa='$_KUBECTL get sa'
alias kgsay='$_KUBECTL get sa -oyaml'
alias kdsa='$_KUBECTL describe sa'

alias kgsec='$_KUBECTL get secret'
alias kgsecy='$_KUBECTL get secret -oyaml'
alias kdsec='$_KUBECTL describe secret'

alias kgcm='$_KUBECTL get configmap'
alias kgcmy='$_KUBECTL get configmap -oyaml'
alias kdcm='$_KUBECTL describe configmap'

alias kgdep='$_KUBECTL get deployment'
alias kgdepy='$_KUBECTL get deployment -oyaml'
alias kddep='$_KUBECTL describe deployment'

alias kgsta='$_KUBECTL get statefulset'
alias kgstay='$_KUBECTL get statefulset -oyaml'
alias kdsta='$_KUBECTL describe statefulset'

alias kgdae='$_KUBECTL get daemonset'
alias kgdaey='$_KUBECTL get daemonset -oyaml'
alias kddae='$_KUBECTL describe daemonset'

alias kl='$_KUBECTL logs'
alias klf='$_KUBECTL logs -f --tail 30'
alias klff='$_KUBECTL logs -f'

alias kgcrd='$_KUBECTL get crd'
alias kgcrdy='$_KUBECTL get crd -oyaml'
alias kdcrd='$_KUBECTL describe crd'

alias kgkz='$_KUBECTL get kustomization'
alias kgkzy='$_KUBECTL get kustomization -oyaml'
alias kdkz='$_KUBECTL describe kustomization'

alias kghr='$_KUBECTL get helmrelease'
alias kghry='$_KUBECTL get helmrelease -oyaml'
alias kdhr='$_KUBECTL describe helmrelease'

alias kges='$_KUBECTL get externalsecret'
alias kgesy='$_KUBECTL get externalsecret -oyaml'
alias kdes='$_KUBECTL describe externalsecret'

alias kgir='$_KUBECTL get ingressroute'
alias kgiry='$_KUBECTL get ingressroute -oyaml'
alias kdir='$_KUBECTL describe ingressroute'
