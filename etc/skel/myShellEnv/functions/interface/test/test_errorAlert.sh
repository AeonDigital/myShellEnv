#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_errorAlert() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(errorAlert "fnName" "expected 2 arguments")
  local testExpected=$(echo -e "${MSE_GB_ALERT_INDENT}${MSE_GB_ALERT_INDENT}${WHITE}ERROR (in fnName) :${NONE} expected 2 arguments")

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
