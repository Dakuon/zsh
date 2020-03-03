# Path to your oh-my-zsh installation.
export TERM="xterm-256color"
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
# export FPATH=/usr/share/zsh/[0-9].[0-9]*/functions:$FPATH

# fix home/end keys
bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line

# font settings
POWERLEVEL9K_MODE="nerdfont-complete"
# prompt settings
POWERLEVEL9K_TRANSIENT_PROMPT=off
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time os_icon host user dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(disk_usage load ram time)
function p10k-on-pre-prompt() { p10k display '1'=show '1/right'=show '1/left/time'=hide '1/left/os_icon'=show '1/left/host'=show '1/left/user'=show '1/left/dir_writeable'=show '1/left/dir'=show '1/left/vcs'=show }
function p10k-on-post-prompt() { p10k display '1/right'=hide '1/left/time'=show '1/left/os_icon'=hide '1/left/host'=hide '1/left/user'=hide '1/left/dir_writeable'=hide '1/left/dir'=show '1/left/vcs'=hide }
# background/foreground settings
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

# set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# load plugins
plugins=(
    git
    sudo
    kubectl
    zsh-autosuggestions
    # zsh-syntax-highlighting
)

# plugin settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue,bold,underline"

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

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
eval `dircolors ~/.lscolors`
# set auto-completion colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# set ls attribute colors
export _LS=(=ls)
export _LS=($_LS -hF  --group-directories-first --time-style=+%d-%m-%Y\ %H:%M)
export _GRC=("grc" "--config=$HOME/.lsregex")
alias ls='$_GRC $_LS --color -C $@'
alias l='$_GRC $_LS --color -la $@'
alias la='$_GRC $_LS --color -C -A $@'
alias ll='$_GRC $_LS --color -la $@'

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

# Syntax highlighting
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh

# Kubectl autocompletion
if [ -x "$(kubectl 2>&1)" ]; then
  alias k=kubectl
  source <(kubectl completion zsh)
fi
