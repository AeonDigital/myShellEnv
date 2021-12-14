#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_toUpperCase() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(toUpperCase "convert To Upper Case")
  local testExpected="CONVERT TO UPPER CASE"

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
