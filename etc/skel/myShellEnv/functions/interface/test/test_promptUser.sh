#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_promptUser() {
  MSE_GB_PROMPT_MSG[0]=$(printf "Você deseja prosseguir?")

  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(echo -e "s" | promptUser)
  local testExpected=$(echo -e "${MSE_GB_PROMPT_INDENT}Você deseja prosseguir?")

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
  testResult=$(MSE_GB_PROMPT_TEST=1 && echo -e "s" | promptUser)
  testExpected=1
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
  testResult=$(MSE_GB_PROMPT_TEST=1 && echo -e "n" | promptUser)
  testExpected=0
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
  declare -A MSE_GB_PROMPT_LIST_OPTIONS_VALUES=(["arch"]="Arch" ["ubuntu"]="Ubuntu" ["debian"]="Debian")
  testResult=$(MSE_GB_PROMPT_TEST=1 && echo -e "arch" | promptUser "list")
  testExpected="Arch"
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
  testResult=$(MSE_GB_PROMPT_TEST=1 && echo -e "my own value" | promptUser "value")
  testExpected="my own value"
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
