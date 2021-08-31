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
  TMP=$(trimDL $1 $2)
  TMP=$(trimDR $1 $TMP)
  echo $TMP
}
