export FPATH=~/.completion:$FPATH
export ZIM_HOME=~/.zim
export TERM="xterm-256color"
export HISTCONTROL="ignorespace"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

setopt no_nomatch
setopt interactivecomments
setopt hash_list_all

# font settings
POWERLEVEL9K_MODE="nerdfont-complete"
# prompt settings
POWERLEVEL9K_TRANSIENT_PROMPT=off
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time os_icon context dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(aws_vault_profile aws_vault_expire kubecontext disk_usage load ram time)
function p10k-on-pre-prompt() { p10k display '1'=show '1/right'=show '1/left/time'=hide '1/left/os_icon'=show '1/left/context'=show '1/left/dir_writeable'=show '1/left/dir'=show '1/left/vcs'=show '1/right/disk_usage'=show '1/right/load'=show '1/right/ram'=show '1/right/time'=show '1/right/aws_vault_expire'=show }
function p10k-on-post-prompt() { p10k display '1/right'=show '1/left/time'=show '1/left/os_icon'=hide '1/left/context'=show '1/left/dir_writeable'=hide '1/left/dir'=show '1/left/vcs'=hide '1/right/disk_usage'=hide '1/right/load'=hide '1/right/ram'=hide '1/right/time'=hide '1/right/aws_vault_expire'=hide }

# prompt theme settings
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%F{green}❯%f '
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_OS_ICON_BACKGROUND="black"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_HOST_REMOTE_BACKGROUND="darkseagreen"
POWERLEVEL9K_HOST_REMOTE_FOREGROUND="black"
POWERLEVEL9K_HOST_LOCAL_BACKGROUND="darkseagreen"
POWERLEVEL9K_HOST_LOCAL_FOREGROUND="black"
POWERLEVEL9K_AWS_BACKGROUND="blue"
POWERLEVEL9K_AWS_FOREGROUND="white"
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=160
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=7
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND=232
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND=232
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND=7
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND=7
POWERLEVEL9K_CONTEXT_FOREGROUND=232
POWERLEVEL9K_CONTEXT_BACKGROUND=7
POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%n@%m'
POWERLEVEL9K_CONTEXT_REMOTE_TEMPLATE='%n@%m'
POWERLEVEL9K_CONTEXT_REMOTE_SUDO_TEMPLATE='%n@%m'

# plugin settings
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue,bold,underline"

# kubectl customizations
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|kubecolor|helm|kubectl-ns|kubectl-ctx|oc|istioctl|kogito|kubectl-view_secret|kubectl-neat|k9s'
POWERLEVEL9K_KUBECONTEXT_DEV_VISUAL_IDENTIFIER_EXPANSION='✅'
POWERLEVEL9K_KUBECONTEXT_DEV_CONTENT_EXPANSION='Dev > ${P9K_CONTENT} <'
POWERLEVEL9K_KUBECONTEXT_PROD_VISUAL_IDENTIFIER_EXPANSION='🔥'
POWERLEVEL9K_KUBECONTEXT_PROD_CONTENT_EXPANSION='Prod > ${P9K_CONTENT} <'
POWERLEVEL9K_KUBECONTEXT_DEFAULT_BACKGROUND="blue"
POWERLEVEL9K_KUBECONTEXT_DEV_BACKGROUND="darkgreen"
POWERLEVEL9K_KUBECONTEXT_PROD_BACKGROUND="darkred"
POWERLEVEL9K_KUBECONTEXT_CLASSES=('*dev*' DEV '*prod*' PROD '*' DEFAULT)

# aws customizations
POWERLEVEL9K_AWS_VAULT_PROFILE_DEV_BACKGROUND="darkgreen"
POWERLEVEL9K_AWS_VAULT_PROFILE_DEV_VISUAL_IDENTIFIER_EXPANSION='✅'
POWERLEVEL9K_AWS_VAULT_PROFILE_DEV_CONTENT_EXPANSION='Dev > ${P9K_CONTENT} <'
POWERLEVEL9K_AWS_VAULT_PROFILE_PROD_BACKGROUND="darkred"
POWERLEVEL9K_AWS_VAULT_PROFILE_PROD_VISUAL_IDENTIFIER_EXPANSION='🔥'
POWERLEVEL9K_AWS_VAULT_PROFILE_PROD_CONTENT_EXPANSION='Prod > ${P9K_CONTENT} <'
POWERLEVEL9K_AWS_VAULT_PROFILE_CLASSES=('dev*' DEV 'prod*' PROD '*' DEFAULT)

# Source custom settings
if [ -f ~/.zsh/local/custom.zsh ]; then
  source ~/.zsh/local/custom.zsh
fi

# Load libs
source ~/.zsh/libs/main.zsh

# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Create dir for completions
if [ ! -d ~/.completion ]; then
  mkdir -p ~/.completion
fi

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

# set auto-completion colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# allow zsh to rehash command list
zstyle ":completion:*:commands" rehash 1

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

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

# Remove duplicate entries from $PATH
typeset -U path
