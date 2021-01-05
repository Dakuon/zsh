if [ ! -f ~/.completion/kubeadm.zsh || ${COMP_UPDATE} ]; then
  kubeadm completion zsh > ~/.completion/kubeadm.zsh
fi

source ~/.completion/kubeadm.zsh
