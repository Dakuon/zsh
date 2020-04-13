#######################
# Libs
#######################
source ${HOME}/.zsh/libs/completion.zsh
source ${HOME}/.zsh/libs/directories.zsh
source ${HOME}/.zsh/libs/history.zsh
source ${HOME}/.zsh/libs/keybinds.zsh

if [ $commands[kubectl] ]; then
  source ${HOME}/.zsh/libs/kubectl.zsh
fi

#######################
# Completion
#######################
if [ $commands[hal] ]; then
  source ${HOME}/.zsh/completion/halyard.zsh
fi

if [ $commands[helm] ]; then
  source ${HOME}/.zsh/completion/helm.zsh
fi

if [ $commands[kubeadm] ]; then
  source ${HOME}/.zsh/completion/kubeadm.zsh
fi
