#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# @desc
# Desinstala o 'myShellEnv'.
#
# @param bool $1
# Use '0' ou omita este parametro para desinstalar apenas para
# o seu usuário.
# Use '1' se deseja desinstalar globalmente. Esta opção apenas
# funciona se for rodada como 'sudo' e não desinstala as instalações
# individuais de cada um dos usuários.
mse_uninstall() {
  if [ $EUID == 0 ]; then
    echo $1 # todo
  fi
}
