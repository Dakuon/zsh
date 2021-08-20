export FPATH=~/.completion:$FPATH
export TERM="xterm-256color"
export HISTCONTROL="ignorespace"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

setopt no_nomatch
setopt interactivecomments

autoload -Uz compinit
compinit

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

# plugin settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=blue,bold,underline"
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|kubecolor|helm|kubectl-ns|kubectl-ctx|oc|istioctl|kogito|kubectl-view_secret|kubectl-neat'

# Install zplug
source ~/.zsh/libs/zplug.zsh

# Install/Load plugins/theme
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "ahmetb/kubectx", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "MichaelAquilina/zsh-you-should-use", from:github
zplug "trapd00r/zsh-syntax-highlighting-filetypes", defer:3
zplug "bobsoppe/zsh-ssh-agent", use:ssh-agent.zsh, from:github
zplug 'romkatv/powerlevel10k', as:theme, depth:1

# Source cusom settings
if [ -f ~/.zsh/local/custom.zsh ]; then
  source ~/.zsh/local/custom.zsh
fi

# plugin install and reload shell
if ! zplug check --verbose; then
  if [ -z ${INST} ]; then
    printf "Install? [y/N]: "
    if read -q; then
      echo;
      zplug install
    fi
  else
    echo;
    zplug install
  fi
fi

zplug load

# Fix zplug folder permissions
chmod -R 750 ~/.zplug

# Load plugins not picked up zplug
if zplug check trapd00r/zsh-syntax-highlighting-filetypes; then
  source ~/.zplug/repos/trapd00r/zsh-syntax-highlighting-filetypes/zsh-syntax-highlighting-filetypes.zsh
fi

# Create dir for completions
if [ ! -d ~/.completion ]; then
  mkdir -p ~/.completion
fi

# Load libs
source ~/.zsh/libs/main.zsh

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
