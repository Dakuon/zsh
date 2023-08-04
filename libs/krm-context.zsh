_krm_context () {
  local CONTEXT CLUSTER USER OUTPUT LINES
  if [ -z "${1}" ]; then
    kubectl config get-contexts | tr -d '*' | awk 'NR>1 {print $1}'
    echo -e "\nUsage: krmctx <context>"
    return
  fi

  if ! kubectl config get-contexts "${1}" > /dev/null 2>&1; then
    echo "Failed to get context, check input"
    return
  fi

  OUTPUT=$(kubectl config get-contexts "${1}" | tail -n-1)
  LINES=$(wc -l <<< "${OUTPUT}" | awk '{print $1}')
  if [ "${LINES}" -gt 1 ]; then
    echo "We recieved more than one context"
    echo "${OUTPUT}"
  fi

  CONTEXT=$(echo "${OUTPUT}" | awk '{print $1}')
  CLUSTER=$(echo "${OUTPUT}" | awk '{print $2}')
  USER=$(echo "${OUTPUT}" | awk '{print $3}')

  echo "Context: ${CONTEXT}"
  echo "Cluster: ${CLUSTER}"
  echo "User: ${USER}"

  while true; do
    vared -p 'Do you wish to remove this context [Y]es/[N]o?: ' -c answer
    case $answer in
        [Yy]|[Yy][Ee][Ss] ) unset answer; break;;
        [Nn]|[Nn][Oo] ) unset answer; return;;
        * ) echo "Invalid input. Please answer [Y]es/[N]o."; unset answer;;
    esac
  done
  
  echo "Making backup of ~/.kube/config to ~/.kube/config.backup"
  cp ~/.kube/config ~/.kube/config.backup
  kubectl config delete-context "${CONTEXT}"
  kubectl config delete-cluster "${CLUSTER}"
  kubectl config delete-user "${USER}"
  echo "Context ${CONTEXT} removed"
}