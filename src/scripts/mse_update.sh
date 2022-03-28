#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# @desc
# Instala atualizações do 'myShellEnv', se houverem.
mse_update() {
  printf "===== UPDATE 'myShellEnv' =====\n"
  git -C "${HOME}/.myShellEnv" pull
  git -C "${HOME}/.myShellEnv" submodule update --remote
  printf "===== UPDATE 'myShellEnv' END =====\n"
  printf "===== Updates will be loaded on next shell startup =====\n"
}
