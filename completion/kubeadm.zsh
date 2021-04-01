if [[ ! -f ~/.completion/_kubeadm || ${COMP_UPDATE} ]]; then
  kubeadm completion zsh > ~/.completion/_kubeadm
fi
