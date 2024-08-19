function prompt_aws_vault_expire() {
  if [ -z "$AWS_VAULT" ]; then
    return # aws-vault session is not active
  fi

  local current_time
  current_time=`date -u +'%Y-%m-%dT%H:%M:%SZ'`
  local current_epoch
  current_epoch=`date -j -u -f '%Y-%m-%dT%H:%M:%SZ' "$current_time" '+%s'`

  local expiration_epoch
  expiration_epoch=`date -j -u -f '%Y-%m-%dT%H:%M:%SZ' "$AWS_CREDENTIAL_EXPIRATION" '+%s'`

  local seconds_until_expiration
  seconds_until_expiration=`expr "$expiration_epoch" '-' "$current_epoch"`

  local minutes_until_expiration
  minutes_until_expiration=`expr "$seconds_until_expiration" '/' 60`

  if [ "$seconds_until_expiration" -le 0 ]; then
    p10k segment -s EXPIRED -b red -f black -t " Expired!" 
  elif [ "$minutes_until_expiration" -lt "${POWERLEVEL9K_AWS_VAULT_RUNNING_OUT_THRESHOLD_MINUTES:-15}" ]; then
    p10k segment -s RUNNING_OUT -b yellow -f black -t " Expire: ${minutes_until_expiration}m"
  else
    p10k segment -s WORKING -b green -t " Expire: ${minutes_until_expiration}m"
  fi
}

function prompt_aws_vault_profile() {
  if [ -z "$AWS_VAULT" ]; then
    return # aws-vault session is not active
  fi

  local CURRENT_CLASS=DEFAULT
  for ((i = 0; i < ${#POWERLEVEL9K_AWS_VAULT_PROFILE_CLASSES[@]}; i+=2)); do
    local PATTERN="${POWERLEVEL9K_AWS_VAULT_PROFILE_CLASSES[i+1]}"
    if [ "${PATTERN}" = '*' ]; then
      break
    fi

    local CLASS="${POWERLEVEL9K_AWS_VAULT_PROFILE_CLASSES[i+2]}"
    if [[ "${AWS_VAULT}" =~ "${PATTERN}" ]]; then
      CURRENT_CLASS="${CLASS}"
      break
    fi
  done

  p10k segment -s ${CURRENT_CLASS} -t "${AWS_VAULT}"
}

typeset -g POWERLEVEL9K_AWS_VAULT_PROFILE_CLASSES=(
  '*' DEFAULT
)

typeset -g POWERLEVEL9K_AWS_VAULT_PROFILE_DEFAULT_BACKGROUND="darkblue"
typeset -g POWERLEVEL9K_AWS_VAULT_PROFILE_DEFAULT_FOREGROUND="white"
typeset -g POWERLEVEL9K_AWS_VAULT_PROFILE_DEFAULT_VISUAL_IDENTIFIER_EXPANSION=''
typeset -g POWERLEVEL9K_AWS_VAULT_PROFILE_DEFAULT_CONTENT_EXPANSION='AWS > ${P9K_CONTENT} <'
