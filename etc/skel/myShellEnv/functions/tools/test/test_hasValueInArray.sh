#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_hasValueInArray() {
  ((mseCountAssert=mseCountAssert+1))
  ALLOWED_ENVIRONMENT_TYPES=(
    "UTEST" "LCL" "DEV" "HMG" "QA" "PRD"
  )
  local testResult=$(hasValueInArray "LCL" "ALLOWED_ENVIRONMENT_TYPES")
  local testExpected="1"

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
  local testResult=$(hasValueInArray "NON" "ALLOWED_ENVIRONMENT_TYPES")
  local testExpected="0"

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
