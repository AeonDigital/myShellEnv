#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_convertDecimalToHex() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(convertDecimalToHex "195 173")
  local testExpected="C3 AD"

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
