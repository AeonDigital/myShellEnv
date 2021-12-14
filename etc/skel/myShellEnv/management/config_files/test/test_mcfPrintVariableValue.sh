#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_mcfPrintVariableValue() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(mcfPrintVariableValue "GIT_LOG_LENGTH" "${mseTMPDIR}/test/.config")
  local testExpected="10"

  if [ "$testResult" == "$testExpected" ]; then
    testISOK=1
    echo "   OK"
  else
    testISOK=0
    echo "   FAIL"
    echo "   Result  : $testResult"
    echo "   Expected: $testExpected"
  fi


  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(mcfPrintSectionVariableValue "teste" "GIT_LOG_LENGTH" "${mseTMPDIR}/test/.config")
  local testExpected="20"

  if [ "$testResult" == "$testExpected" ]; then
    testISOK=1
    echo "   OK"
  else
    testISOK=0
    echo "   FAIL"
    echo "   Result  : $testResult"
    echo "   Expected: $testExpected"
  fi
}
