#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_convertOctalToDecimal() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(convertOctalToDecimal "303 255")
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
