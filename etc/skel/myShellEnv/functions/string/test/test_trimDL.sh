#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_trimDL() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(trimDL "," "  Keep  calm   ,   and   ... ,   think  ")
  local testExpected="  Keep  calm,   and   ...,   think  "

  if [ "${testResult}" == "$testExpected" ]; then
    testISOK=1
    echo "   OK"
  else
    testISOK=0
    echo "   FAIL"
    echo "   Result  : ${testResult}"
    echo "   Expected: ${testExpected}"
  fi
}