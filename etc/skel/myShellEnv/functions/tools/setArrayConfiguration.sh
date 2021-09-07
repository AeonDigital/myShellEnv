#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Permite editar um arquivo de configuração que armazene informações
# em formato de array.
# Note que todo o array é sobrescrito com o novo valor indicado.
#
#   @param string $1
#   Nome do array que será alterado.
#
#   @param string $2
#   Nome do array que contém a nova configuração a ser definida.
#   Deve ser um array global.
#
#   @param string $3
#   Arquivo onde a alteração será feita.
#
#   @example
#     setArrayConfiguration 'ARRAY_NAME' 'ARRAY_VALUES' '~/myShellEnv/functions/terminal/promptConfig.sh'
#
setArrayConfiguration() {
  if [ $# != 3 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 3 arguments"
  else
    if [ ! -f $3 ]; then
      errorAlert "${FUNCNAME[0]}" "especified file not found"
    else

      while read line; do
        echo $line
      done < $3
    fi
  fi
}
