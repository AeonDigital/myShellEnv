#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_mcfPrintVariables() {
  if [ ! -f "${mseTMPDIR}/test/expected/test_mcfPrintSectionVariables_01" ]; then
    mcfPrintVariables "${mseTMPDIR}/test/.config"
  fi


  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(mcfPrintVariables "${mseTMPDIR}/test/.config")
  local testExpected=$(< "${mseTMPDIR}/test/expected/test_mcfPrintSectionVariables_01")

  if [ "$testResult" == "$testExpected" ]; then
    testISOK=1
    echo "   OK"
  else
    testISOK=0
    echo "   FAIL"
    echo "   Result  : ${testResult}"
    echo "   Expected: ${testExpected}"
  fi



  if [ ! -f "${mseTMPDIR}/test/expected/test_mcfPrintSectionVariables_02" ]; then
    mcfPrintSectionVariables "webserver" "${mseTMPDIR}/test/.config"
  fi


  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(mcfPrintSectionVariables "webserver" "${mseTMPDIR}/test/.config")
  local testExpected=$(< "${mseTMPDIR}/test/expected/test_mcfPrintSectionVariables_02")

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
