function zcompare() {
  if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
    zcompile ${1}
  fi
}

# zcompile .zshrc
zcompare ${HOME}/.zshrc

# zcompile the completion cache
zcompare ${HOME}/.zcompdump

# cleanup
unfunction zcompare
