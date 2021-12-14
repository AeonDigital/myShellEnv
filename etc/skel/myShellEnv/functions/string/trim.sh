#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Elimina qualquer espaços em branco no início ou no final de uma string.
#
#   @param string $1
#   String que será alterada.
#
#   @example
#     result=$(trim "   texto  aqui   ")
#     echo $result # "texto  aqui"
#
trim() {
  echo "$1" | sed 's/^\s*//g' | sed 's/\s*$//g'

  # a opção abaixo elimina toda ocorrencia de
  # múltiplos espaços entre as palavras
  # portanto não é adequada ao que se deseja.
  # echo "$1" | xargs
}





#
# Teste
test_trim() {
  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(trim "   texto   aqui   ")
  local testExpected="texto   aqui"

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
