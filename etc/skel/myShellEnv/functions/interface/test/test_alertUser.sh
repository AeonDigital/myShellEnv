#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_alertUser() {
  MSE_GB_ALERT_MSG[0]="Testando alert"

  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(alertUser)
  local testExpected=$(echo -e "${MSE_GB_ALERT_INDENT}Testando alert")

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
