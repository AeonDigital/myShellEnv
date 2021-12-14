#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_convertHexToDecimal() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(convertHexToDecimal "C3 AD")
  local testExpected="195 173"

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
