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
  unset KUBE_UPDATE
fi

# Set up commands
source "${HOME}/.zsh/libs/krm-context.zsh"
alias krmctx='_krm_context'

# kubectl-krew
alias kkrew=~/.krew/bin/kubectl-krew

# kubectl
source ~/.zsh/completion/kubectl.zsh
if [ $commands[kubecolor] ]; then
  compdef kubecolor=kubectl
  export _KUBECTL=(=kubecolor)
  alias k=kubecolor

  export KUBECOLOR_THEME_TABLE_HEADER=#5a8487
  export KUBECOLOR_PRESET="protanopia-dark"
  export KUBECOLOR_OBJ_FRESH=10m
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

# kubectl-iexec
alias kexec="kubectl-iexec"

# kubectl-neat
alias kn="kubectl-neat"

# kubectl-images
alias kimages="kubectl-images"

# kubectl-images
alias kdf="kubectl-df_pv"

alias kg="$_KUBECTL get -owide"
alias kgy="$_KUBECTL get -oyaml $@"
alias kd="$_KUBECTL describe"
alias ka="$_KUBECTL apply -f $@"
alias kak="$_KUBECTL apply -k $@"
alias krm="$_KUBECTL delete"

alias kgp="$_KUBECTL get -owide po"
alias kgpy="$_KUBECTL get -oyaml po"
alias kdp="$_KUBECTL describe pod"
alias ktp="$_KUBECTL top pods"

alias kgn="$_KUBECTL get -owide node"
alias kgny="$_KUBECTL get -oyaml node"
alias kdn="$_KUBECTL describe node"
alias ktn="$_KUBECTL top node"

alias kgsvc="$_KUBECTL get -owide svc"
alias kgsvcy="$_KUBECTL get -oyaml svc"
alias kdsvc="$_KUBECTL describe svc"

alias kgep="$_KUBECTL get ep"
alias kgepy="$_KUBECTL get -oyaml ep"
alias kdep="$_KUBECTL describe ep"

alias kgns="$_KUBECTL get ns"
alias kgnsy="$_KUBECTL get -oyaml ns"
alias kdns="$_KUBECTL describe ns"

alias kgsa="$_KUBECTL get sa"
alias kgsay="$_KUBECTL get -oyaml sa"
alias kdsa="$_KUBECTL describe sa"

alias kgsec="$_KUBECTL get secret"
alias kgsecy="$_KUBECTL get -oyaml secret"
alias kdsec="$_KUBECTL describe secret"

alias kgcm="$_KUBECTL get configmap"
alias kgcmy="$_KUBECTL get -oyaml configmap"
alias kdcm="$_KUBECTL describe configmap"

alias kgdep="$_KUBECTL get deployment"
alias kgdepy="$_KUBECTL get -oyaml deployment"
alias kddep="$_KUBECTL describe deployment"

alias kgsta="$_KUBECTL get statefulset"
alias kgstay="$_KUBECTL get -oyaml statefulset"
alias kdsta="$_KUBECTL describe statefulset"

alias kgdae="$_KUBECTL get daemonset"
alias kgdaey="$_KUBECTL get -oyaml daemonset"
alias kddae="$_KUBECTL describe daemonset"

alias kl="$_KUBECTL logs"
alias klf="$_KUBECTL logs -f --tail 30"
alias klff="$_KUBECTL logs -f"

alias kgcrd="$_KUBECTL get crd"
alias kgcrdy="$_KUBECTL get -oyaml crd"
alias kdcrd="$_KUBECTL describe crd"

alias kgkz="$_KUBECTL get kustomization"
alias kgkzy="$_KUBECTL get -oyaml kustomization"
alias kdkz="$_KUBECTL describe kustomization"

alias kghr="$_KUBECTL get helmrelease"
alias kghry="$_KUBECTL get -oyaml helmrelease"
alias kdhr="$_KUBECTL describe helmrelease"

alias kges="$_KUBECTL get externalsecret"
alias kgesy="$_KUBECTL get -oyaml externalsecret"
alias kdes="$_KUBECTL describe externalsecret"

alias kgir="$_KUBECTL get ingressroute"
alias kgiry="$_KUBECTL get -oyaml ingressroute"
alias kdir="$_KUBECTL describe ingressroute"
