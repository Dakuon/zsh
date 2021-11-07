if [ -z ${SSH_FORWARD} ] || ${SSH_FORWARD}; then
  alias ssh="ssh -A"
fi

# SSH hosts autocomplete
HOSTS=()
INCLUDES=()
USERS=("root" ${USER})

if [ -f ~/.ssh/config ]; then
  HOSTS=(${HOSTS} ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
  INCLUDES=($(awk '/Include/{print $2}' ~/.ssh/config))
fi

if [ ! ${#INCLUDES[@]} -eq 0 ]; then
  for INCLUDE in ${INCLUDES[@]}; do
    FILE=$(echo ${INCLUDE} | sed "s;~/;$HOME/;")
    if [ -f "${FILE}" ]; then
      HOSTS=(${HOSTS} ${${${(@M)${(f)"$(cat ${FILE})"}:#Host *}#Host }:#*[*?]*})
    fi
  done
fi

if [[ ${#HOSTS} -gt 0 ]]; then
  zstyle ':completion:*:(ssh|scp|ftp|rsync):*' format ' %F{yellow}-- %d --%f'
  zstyle ':completion:*:(ssh|scp|ftp|rsync):*' group-name ''

  zstyle ':completion:*:(ssh|scp|ftp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
  zstyle ':completion:*:(ssh|scp|ftp|rsync):*' group-order users hosts

  zstyle ':completion:*:(ssh|scp|ftp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
  zstyle ':completion:*:(ssh|scp|ftp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

  zstyle ':completion:*:(ssh|scp|ftp|rsync):*' users $USERS
  zstyle ':completion:*:(ssh|scp|ftp|rsync):*' hosts $HOSTS
fi
