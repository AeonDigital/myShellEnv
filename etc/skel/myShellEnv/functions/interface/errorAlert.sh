#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Mostra uma mensagem de alerta para o usuário indicando um erro
# ocorrido em algum script.
#
#   @param string $1
#   Nome da função onde ocorreu o erro.
#   Se não for definido, usará o valor padrão 'script'.
#
#   @param string $2
#   Mensagem de erro.
#
#   @example
#     errorAlert "" "expected 2 arguments"
#     errorAlert ${FUNCNAME[0]} "expected 2 arguments"
#
errorAlert() {
  if [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 2 arguments"
  else
    LOCAL=$1
    if [ $1 == "" ]; then
      LOCAL="script"
    fi

    setIMessage "${ALERT_INDENT}${SILVER}ERROR (in ${LOCAL}) :${NONE} $2" 1
    alertUser
  fi
}
