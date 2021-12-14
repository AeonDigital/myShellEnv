#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Permite editar um arquivo de configuração que armazene informações
# do tipo chave=valor.
#
#   @param string $1
#   Nome da propriedade que deve ser alterada.
#
#   @param string $2
#   Valor que será definido para a propriedade.
#
#   @param string $3
#   Arquivo onde a alteração será feita.
#
#   @example
#     setKeyValueConfiguration 'PROMPT_STYLE' 'NEWLINE01' '~/myShellEnv/functions/terminal/promptConfig.sh'
#
setKeyValueConfiguration() {
  if [ $# != 3 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 3 arguments"
  else
    if [ ! -f $3 ]; then
      errorAlert "${FUNCNAME[0]}" "especified file not found"
    else
      sed -i "s/^\($1\s*=\s*\).*\$/\1$2/" $3
    fi
  fi
}
