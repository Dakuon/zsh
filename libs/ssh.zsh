if [ -z ${SSH_FORWARD} ] || ${SSH_FORWARD}; then
  export _SSH=("ssh" "-A")
  alias ssh='$_SSH $@'
  unset SSH_FORWARD
fi
