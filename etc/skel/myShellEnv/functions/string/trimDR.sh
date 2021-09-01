#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Elimina qualquer espaço em branco existente imediatamente
# APÓS do delimitador indicado.
#
#   @param string $1
#   Delimitador.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimDR "," "Keep calm   ,   and...")
#     echo $result # "Keep calm   ,and..."
#
trimDR() {
  # sed 's/,\s*/,/g' <<< "Keep calm   ,   and..."
  mseREG='s/'"$1"'\s*/'"$1"'/g'
  TMP="$(echo $2 | sed ${mseREG})"
  echo $TMP

  unset mseREG
}
