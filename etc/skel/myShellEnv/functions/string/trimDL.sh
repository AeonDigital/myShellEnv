#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







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
  sed 's/\s*'"$1"'/'"$1"'/g' <<< "$2"
}





#
# Teste
test_trimDL() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(trimDL "," "  Keep  calm   ,   and   ... ,   think  ")
  local testExpected="  Keep  calm,   and   ...,   think  "

  if [ "${testResult}" == "$testExpected" ]; then
    testISOK=1
    echo "   OK"
  else
    testISOK=0
    echo "   FAIL"
    echo "   Result  : ${testResult}"
    echo "   Expected: ${testExpected}"
  fi
}
