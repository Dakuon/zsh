# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export LANG=en_US.UTF-8

autoload -Uz compinit
compinit

# Load libs
source ${HOME}/.zsh/configs/libs/completion.zsh
source ${HOME}/.zsh/configs/libs/directories.zsh
source ${HOME}/.zsh/configs/libs/history.zsh
source ${HOME}/.zsh/configs/libs/keybinds.zsh

# Install zplug
if [ ! -d "${HOME}/.zplug" ]; then
  wget -qO- https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  RELOAD=true
  sleep 5
else
  unset RELOAD
fi

# Fix zplug folder permissions
chmod -R 750 ${HOME}/.zplug

# Load zplug
source ${HOME}/.zplug/init.zsh
# Install/Load plugins/theme
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/sudo",   from:oh-my-zsh
zplug "plugins/extract",  from:oh-my-zsh
zplug "plugins/command-not-found",  from:oh-my-zsh
zplug "ahmetb/kubectx", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "trapd00r/zsh-syntax-highlighting-filetypes", defer:3
zplug 'romkatv/powerlevel10k', as:theme, depth:1
zplug load

# zplug install and source .zshrc again
if [[ -n "$RELOAD" ]]; then
  echo Install plugins
  zplug install
  chmod -R 750 ${HOME}/.zplug
  echo Reload .zshrc
  exec zsh
fi

# Load plugins
source ${HOME}/.zplug/repos/trapd00r/zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh

# Kubectl autocompletion
if [ -x "$(which kubectl 2>&1)" ]; then
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
      kubectl krew install $(echo $PLUGIN | cut -d '-' -f 2) 2> /dev/null
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

# font settings
POWERLEVEL9K_MODE="nerdfont-complete"
# prompt settings
POWERLEVEL9K_TRANSIENT_PROMPT=off
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time os_icon host user dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext disk_usage load ram time)
function p10k-on-pre-prompt() { p10k display '1'=show '1/right'=show '1/left/time'=hide '1/left/os_icon'=show '1/left/host'=show '1/left/user'=show '1/left/dir_writeable'=show '1/left/dir'=show '1/left/vcs'=show '1/right/disk_usage'=show '1/right/load'=show '1/right/ram'=show '1/right/time'=show }
function p10k-on-post-prompt() { p10k display '1/right'=show '1/left/time'=show '1/left/os_icon'=hide '1/left/host'=hide '1/left/user'=hide '1/left/dir_writeable'=hide '1/left/dir'=show '1/left/vcs'=hide '1/right/disk_usage'=hide '1/right/load'=hide '1/right/ram'=hide '1/right/time'=hide }
# prompt theme settings
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%F{blue}╭─%F{red}'
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{blue}╰%f '
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_HOST_REMOTE_BACKGROUND="darkseagreen"
POWERLEVEL9K_HOST_REMOTE_FOREGROUND="black"
POWERLEVEL9K_HOST_LOCAL_BACKGROUND="darkseagreen"
POWERLEVEL9K_HOST_LOCAL_FOREGROUND="black"
POWERLEVEL9K_KUBECONTEXT_BACKGROUND="blue"
POWERLEVEL9K_KUBECONTEXT_FOREGROUND="white"
# icon settings - Win10 Icons for MesloLGS NF
if [ ! -z "$SSHCLIENT" ]; then
  POWERLEVEL9K_LINUX_ICON="\uE712"
  POWERLEVEL9K_LINUX_CENTOS_ICON="\uF304"
  POWERLEVEL9K_LINUX_UBUNTU_ICON="\uE73A"
  POWERLEVEL9K_OK_ICON="\uf42e"
  POWERLEVEL9K_HOME_ICON="\uFB9F"
  POWERLEVEL9K_HOME_SUB_ICON="\uFB9F"
  POWERLEVEL9K_FOLDER_ICON="\uFC6E"
  POWERLEVEL9K_ETC_ICON="\uF992"
  POWERLEVEL9K_USER_ICON="\uF415"
  POWERLEVEL9K_ROOT_ICON="\ue20f"
  POWERLEVEL9K_SUDO_ICON="\ue20f"
  POWERLEVEL9K_LOCK_ICON="\uFAFA"
  POWERLEVEL9K_RAM_ICON="\uF85A"
  POWERLEVEL9K_DISK_ICON="\uF7C9"
  POWERLEVEL9K_LOAD_ICON="\uF2DB"
  POWERLEVEL9K_TIME_ICON="\uF64F"
  POWERLEVEL9K_PYTHON_ICON="\uE235"
  POWERLEVEL9K_SERVER_ICON="\uF308"
  POWERLEVEL9K_VCS_GIT_ICON="\uF408 "
  POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON="\uF408 "
  POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uF408 "
  POWERLEVEL9K_VCS_GIT_GITLAB_ICON="\uF408 "
  POWERLEVEL9K_VCS_BRANCH_ICON="\uE0A0 "
  POWERLEVEL9K_VCS_STASH_ICON="\uF47F"
  POWERLEVEL9K_VCS_STAGED_ICON="\uF6B2"
  POWERLEVEL9K_VCS_UNSTAGED_ICON="\uF009"
  POWERLEVEL9K_VCS_UNTRACKED_ICON="\uF7D5"
  POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="\uF175"
  POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="\uF176"
  # POWERLEVEL9K_VCS_BOOKMARK_ICON="\u"
  # POWERLEVEL9K_VCS_COMMIT_ICON="\u"
  # POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON="\u"
  # POWERLEVEL9K_VCS_TAG_ICON="\u"
fi

# plugin settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue,bold,underline"
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubectl-ns|kubectl-ctx|oc|istioctl|kogito'

# color formatting for man pages
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;36m'     # begin blink
export LESS_TERMCAP_so=$'\e[1;33;44m'  # begin reverse video
export LESS_TERMCAP_us=$'\e[1;37m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
export MANPAGER='less -s -M -R +Gg'

# set ls file/folder colors
eval `dircolors ${HOME}/.zsh/configs/.lscolors`
# set auto-completion colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# fix slow-paste caused by zsh-autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions/issues/238#issuecomment-389324292
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
