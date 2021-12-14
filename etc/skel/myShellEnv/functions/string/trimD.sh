#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







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
#     result=$(trimD ":" "  Keep  calm   :   and   ... :   think  ")
#     echo $result # "Keep  calm:and   ...:think"
#
trimD() {
  sed 's/\s*'"$1"'\s*/'"$1"'/g' <<< "$2"
}





#
# Teste
test_trimD() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(trimD ":" "  Keep  calm   :   and   ... :   think  ")
  local testExpected="  Keep  calm:and   ...:think  "

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
