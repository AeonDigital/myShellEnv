#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Elimina qualquer espaço em branco no final da string indicada.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trimR "   texto aqui   ")
#     echo $result # "   texto aqui"
#
trimR() {
  echo "$1" | sed 's/\s*$//g'
}





#
# Teste
test_trimR() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(trimR "   texto aqui   ")
  local testExpected="   texto aqui"

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
