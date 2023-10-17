complete -o nospace -C $(which terraform) terraform tf tofu

if [ $commands[tofu] ]; then
  alias terraform=tofu
fi

alias tf=terraform
