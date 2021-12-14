#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







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
