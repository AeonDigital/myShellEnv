#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Converte o argumento passado para minúsculas.
#
#   @param string $1
#   String que será convertida
#
#   @example
#     result=$(toLowerCase "TEXT")
#
toLowerCase() {
  echo "$1" | awk '{print tolower($0)}'
}





#
# Teste
test_toLowerCase() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(toLowerCase "CONVERT To Lower Case")
  local testExpected="convert to lower case"

  if [ "$testResult" == "$testExpected" ]; then
    testISOK=1
    echo "   OK"
  else
    testISOK=0
    echo "   FAIL"
    echo "   Result  : ${testResult}"
    echo "   Expected: ${testExpected}"
  fi
}
