#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_mcfPrintVariable() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(mcfPrintVariable "CONTAINER_WEBSERVER_NAME" "${mseTMPDIR}/test/.config")
  local testExpected="CONTAINER_WEBSERVER_NAME    =   dev-php-webserver"

  if [ "$testResult" == "$testExpected" ]; then
    testISOK=1
    echo "   OK"
  else
    testISOK=0
    echo "   FAIL"
    echo "   Result  : ${testResult}"
    echo "   Expected: ${testExpected}"
  fi


  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(mcfPrintSectionVariable "teste" "GIT_LOG_LENGTH" "${mseTMPDIR}/test/.config")
  local testExpected="GIT_LOG_LENGTH              =   20"

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
