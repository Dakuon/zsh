###
# Taken from ahmetb/kubectx - https://github.com/ahmetb/kubectx/blob/master/completion/kubectx.bash
###

_kube_namespaces()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "- $(kubectl get namespaces -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}')" -- $curr_arg ) );
}

complete -F _kube_namespaces kubectl-ns kubens kns
