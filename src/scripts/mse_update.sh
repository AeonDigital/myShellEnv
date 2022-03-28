#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# @desc
# Instala atualizações do 'myShellEnv', se houverem.
mse_update() {
  if [ $EUID == 0 ]; then
    git -C "${HOME}/.myShellEnv" pull
    git -C "${HOME}/.myShellEnv" submodule update --remote
  fi
}
