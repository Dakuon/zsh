function zcompare() {
  if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
    zcompile ${1}
  fi
}

autoload -Uz compinit bashcompinit
compinit
bashcompinit

# zcompile .zshrc
zcompare ${HOME}/.zshrc

# zcompile all autoloaded functions
for file in $(ls ${ZPLUG_REPOS}/**/*.zsh); do
  zcompare ${file}
done

# zcompile the completion cache; siginificant speedup.
zcompare ${HOME}/.zcompdump

# cleanup
unfunction zcompare