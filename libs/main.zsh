#######################
# Libs
#######################
source ~/.zsh/libs/completion.zsh
source ~/.zsh/libs/directories.zsh
source ~/.zsh/libs/history.zsh
source ~/.zsh/libs/keybinds.zsh

if [ $commands[kubectl] ]; then
  source ~/.zsh/libs/kubectl.zsh
fi

#######################
# Completion
#######################
if [ $commands[helm] ]; then
  source ~/.zsh/completion/helm.zsh
fi

if [ $commands[kubeadm] ]; then
  source ~/.zsh/completion/kubeadm.zsh
fi

if [ $commands[terraform] ]; then
  source ~/.zsh/completion/terraform.zsh
fi

if [ $commands[aws] ]; then
  source ~/.zsh/completion/aws.zsh
fi

if [ $commands[aws-vault] ]; then
  source ~/.zsh/completion/aws-vault.zsh
fi

compinit

alias update-comp="COMP_UPDATE=true source ~/.zsh/libs/main.zsh"
alias update-kubectl="KUBE_UPDATE=true source ~/.zsh/libs/main.zsh"
