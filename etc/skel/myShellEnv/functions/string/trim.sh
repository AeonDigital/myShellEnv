#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Elimina qualquer espaços em branco no início ou no final de uma string.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trim "   texto aqui   ")
#     echo $result # "texto aqui"
#
trim() {
  echo "$1" | trimL | trim R
}
