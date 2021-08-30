#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
INTERFACE_MSG=()



#
# Adiciona uma nova linha de informação no array de mensagem
# de interface ${INTERFACE_MSG}
#
#   @param string $1
#   Nova linha da mensagem
#
#   @param bool $2
#   Use '1' quando quiser que o array seja reiniciado.
#   Qualquer outro valor não causará efeitos
#
#   @example
#     setIMessage "Atenção" 1
#     setIMessage "Todos os arquivos serão excluídos."
#
setIMessage() {
  if [ $# != 1 ] && [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else
    if [ $# == 2 ] && [ $2 == 1 ]; then
      INTERFACE_MSG=()
    fi

    l=${#INTERFACE_MSG[@]}
    INTERFACE_MSG[l]=$1
  fi
}
