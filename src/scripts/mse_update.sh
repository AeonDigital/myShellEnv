#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# @desc
# Instala atualizações do 'myShellEnv', se houverem.
mse_update() {
  if [ $EUID == 0 ]; then
    echo $1 # todo
  fi
}
