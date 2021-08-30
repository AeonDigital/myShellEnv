#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Converte o argumento passado para maiúsculas.
#
#   @param string $1
#   String que será convertida.
#
#   @example
#     result=$(toUpperCase "TEXT")
#
toUpperCase() {
  echo "$1" | awk '{print toupper($0)}'
}
