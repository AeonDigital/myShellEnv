#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Elimina qualquer espaço em branco existente imediatamente
# ANTES do delimitador indicado.
#
#   @param string $1
#   Delimitador.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimDL "," "Keep calm   ,   and...")
#     echo $result # "Keep calm,   and..."
#
trimDL() {
  REG='s/\s*'"$1"'/'"$1"'/g'
  TMP=$(sed $REG <<< $2)
  echo $TMP
}
