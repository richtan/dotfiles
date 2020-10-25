#!/usr/bin/env zsh

if [ ! -d "${HOME}/.zgen" ]; then
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo "Creating a zgen save..."
  zgen oh-my-zsh

  OMZ_PLUGINS=(
    pipenv
  )
  for omz_plugin in $OMZ_PLUGINS; do
    zgen oh-my-zsh plugins/$omz_plugin
  done

  PLUGINS=(
    laggardkernel/git-ignore
    darvid/zsh-poetry
    zdharma/fast-syntax-highlighting
    zsh-users/zsh-autosuggestions
    zsh-users/zsh-completions
  )

  for plugin in $PLUGINS; do
    zgen load $plugin
  done

  zgen load denysdovhan/spaceship-prompt spaceship

  zgen save
fi

alias ls="lsd"

fpath+=~/.zfunc
autoload -Uz compinit && compinit -i
