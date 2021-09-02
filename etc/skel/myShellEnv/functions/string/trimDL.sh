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
  # sed 's/\s*,/,/g' <<< "Keep calm   ,   and..."
  local mseREG='s/\s*'"$1"'/'"$1"'/g'
  local mseTMP="$(echo $2 | sed ${mseREG})"
  echo $mseTMP
}
