source ~/.zsh/libs/zimfw.zsh
source ~/.zsh/libs/completion.zsh
source ~/.zsh/libs/directories.zsh
source ~/.zsh/libs/history.zsh
source ~/.zsh/libs/keybinds.zsh
source ~/.zsh/libs/title.zsh
source ~/.zsh/libs/get.zsh
source ~/.zsh/libs/update.zsh

if [ $commands[kubectl] ]; then
  source ~/.zsh/libs/kubectl.zsh
  source ~/.zsh/libs/kstatus.zsh
fi

if [ $commands[helm] ]; then
  source ~/.zsh/completion/helm.zsh
fi

if [ $commands[kubeadm] ]; then
  source ~/.zsh/completion/kubeadm.zsh
fi

if [ $commands[kustomize] ]; then
  source ~/.zsh/completion/kustomize.zsh
fi

if [[ $commands[terraform] || $commands[tofu] ]]; then
  source ~/.zsh/completion/terraform.zsh
fi

if [ $commands[aws] ]; then
  source ~/.zsh/completion/aws.zsh
fi

if [ $commands[aws-vault] ]; then
  source ~/.zsh/libs/aws-vault.zsh
  source ~/.zsh/completion/aws-vault.zsh
fi

if [ $commands[podman] ]; then
  source ~/.zsh/completion/podman.zsh
fi

rehash -f

if [[ ${INST} ]]; then
  unset INST
fi

source ~/.zsh/libs/zcompile.zsh

alias update-zsh="_update_zsh"
alias update-kubectl="KUBE_UPDATE=true source ~/.zsh/libs/main.zsh"
