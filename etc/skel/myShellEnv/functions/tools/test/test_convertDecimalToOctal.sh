#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_convertDecimalToOctal() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(convertDecimalToOctal "195 173")
  local testExpected="303 255"

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
