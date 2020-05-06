_kube_secret()
{

  local options="-n" ns="";

  if [[ ${COMP_WORDS[1]} == "-n" ]]; then
    options=""
    ns="-n ${COMP_WORDS[2]}"
  fi

  if [[ ${COMP_WORDS[COMP_CWORD-1]} == "-n" ]]; then
    COMPREPLY=( $(compgen -W "$(kubectl get namespace --output='name' | cut -d'/' -f2)") );
    return
  fi

  if [[ $COMP_CWORD == 1 || $COMP_CWORD == 3 ]]; then
    COMPREPLY=( $(compgen -W "${options} $(kubectl get secret ${ns} --output='name' | cut -d'/' -f2)") );
    return
  fi

  if [[ $COMP_CWORD == 2 || $COMP_CWORD == 4 ]]; then
    COMPREPLY=( $(compgen -W "$(kubectl get secret ${ns} ${COMP_WORDS[COMP_CWORD-1]} -o json | jq -S --raw-output '.data | keys[]')") );
    return
  fi

}

complete -F _kube_secret kubectl-view_secret ksview
