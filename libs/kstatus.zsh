_kfind () {
  sed 1d $KRESOURCES | while read resource; do
    kubectl get $resource --all-namespaces -o wide 2>/dev/null | \
      ${HOME}/.zsh/tools/kfind.awk -v regex="${1}" -v resourcetype="${resource}"
  done
}

_kpfind () {
  column -t <<< $(kubectl get pods --all-namespaces -o wide | \
    ${HOME}/.zsh/tools/kpfind.awk -v regex="${1}")
}

kstatus () {
  # Structured after stack exchange
  iPOSITIONAL=()
  if [ $# -gt 0 ]; then
    ARGS=$(expr $# - 1)
  else
    ARGS=0
  fi

  for i in $(seq 0 $ARGS); do
    key="$1"

    case $key in
      -C) 
        _kpfind Completed
        shift
        ;;
      -c) 
        _kpfind CrashLoopBackOff
        shift
        ;;
      -f) 
        _kpfind Failed
        shift
        ;;
      -p) 
        _kpfind Pending
        shift
        ;;
      -r) 
        _kpfind Running
        shift
        ;;
      -s) 
        _kpfind Succeded
        shift
        ;;
      -u) 
        _kpfind Unknown
        shift
        ;;
      -h|"") 
        echo "Usage: kstatus -[C|c|f|p|r|s|u]"
        echo "  -C                           Completed"
        echo "  -c                           CrashLoopBackOff"
        echo "  -f                           Failed"
        echo "  -p                           Pending"
        echo "  -r                           Running"
        echo "  -s                           Succeeded"
        echo "  -u                           Unknown"
        ;;
    esac
  done
  set -- "${POSITIONAL[@]}" # restore positional parameters
}
