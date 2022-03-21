#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# @desc
# Verifica se existem atualizações a serem feitas.
mse_checkForUpdate() {
  if [ $EUID == 0 ]; then
    echo $1 # todo
  fi
}
