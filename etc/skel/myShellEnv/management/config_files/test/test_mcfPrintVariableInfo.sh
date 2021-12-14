#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_mcfPrintVariableInfo() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(mcfPrintVariableInfo "CONTAINER_WEBSERVER_NAME" "${mseTMPDIR}/test/.config")
  local testExpected=$(echo -e "CONTAINER_WEBSERVER_NAME\ndev-php-webserver")

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
  local testResult=$(mcfPrintSectionVariableInfo "teste" "GIT_LOG_LENGTH" "${mseTMPDIR}/test/.config")
  local testExpected=$(echo -e "GIT_LOG_LENGTH\n20")

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
