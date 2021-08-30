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
setUTF8() {
  if [ ".$1" == ".off" ] ; then
    printf "\033%%@"
    printf "UTF-8 off \n"
  else
    printf "\033%%G"
    printf "UTF-8 on \u2705 \n"
  fi

  printf "\n"
}
