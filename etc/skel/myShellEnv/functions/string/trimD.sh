#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Elimina qualquer espaço em branco existente imediatamente
# ANTES e APÓS o delimitador indicado.
#
#   @param string $1
#   Delimitador.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimD ":" "Keep  calm   :   and   ... :   think")
#     echo $result # "Keep  calm:and   ...:think"
#
trimD() {
  # sed 's/\s*:\s*/:/g' <<< "Keep  calm   :   and   ... :   think"
  mseREG='s/\s*'"$1"'\s*/'"$1"'/g'
  TMP="$(echo $2 | sed ${mseREG})"
  echo $TMP

  unset mseREG
}
