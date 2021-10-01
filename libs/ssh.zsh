if [ -z ${SSH_FORWARD} ] || ${SSH_FORWARD}; then
  alias ssh="ssh -A"
fi
