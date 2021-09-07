#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Permite ativar/desativar o UTF-8 do seu terminal 'bash'.
#
#   @param string $1
#   Indique 'on' para ativar ou 'off' para desativar o UTF-8
#   do seu terminal.
#
#   @example
#     setUTF8 on
#     setUTF8 off
#
setTerminalUTF8() {
  if [ ".$1" == ".off" ]; then
    printf "\033%%@"
    printf "UTF-8 off \n\n"
  elfi [ ".$1" == ".on" ]; then
    printf "\033%%G"
    printf "UTF-8 on \u2658 \n\n"
    # o caracter \u2658 deve aparecer como o cavalo do xadres
  else
    errorAlert "${FUNCNAME[0]}" "invalid argument; expected 'on' or 'off'"
  fi
}
