#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Teste
test_mcfCommentSectionVariable() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(mcfPrintVariable "COMMENT_TEST_NOT" "${mseTMPDIR}/test/.config")
  local testExpected=""

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
  mcfUncommentVariable "COMMENT_TEST_NOT" "#" "${mseTMPDIR}/test/.config"
  local testResult=$(mcfPrintVariable "COMMENT_TEST_NOT" "${mseTMPDIR}/test/.config")
  local testExpected="COMMENT_TEST_NOT            =   value"

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
  mcfCommentVariable "COMMENT_TEST_NOT" "#" "${mseTMPDIR}/test/.config"
  local testResult=$(mcfPrintVariable "COMMENT_TEST_NOT" "${mseTMPDIR}/test/.config")
  local testExpected=""

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
  local testResult=$(mcfPrintSectionVariable "teste" "COMMENT_TEST" "${mseTMPDIR}/test/.config")
  local testExpected=""

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
  mcfUncommentSectionVariable "teste" "COMMENT_TEST" "#" "${mseTMPDIR}/test/.config"
  local testResult=$(mcfPrintSectionVariable "teste" "COMMENT_TEST" "${mseTMPDIR}/test/.config")
  local testExpected="COMMENT_TEST                =   value"

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
  mcfCommentSectionVariable "teste" "COMMENT_TEST" "#" "${mseTMPDIR}/test/.config"
  local testResult=$(mcfPrintSectionVariable "teste" "COMMENT_TEST" "${mseTMPDIR}/test/.config")
  local testExpected=""

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
