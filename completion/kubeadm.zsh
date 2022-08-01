if [[ ! -f ~/.completion/_kubeadm || "$(which kubeadm)" -nt ~/.completion/_kubeadm ]]; then
  kubeadm completion zsh > ~/.completion/_kubeadm
fi
