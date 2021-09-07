#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
MSE_GB_ARRAY_CONFIG=()




#
# Permite editar um arquivo de configuração que armazene informações
# em formato de array.
# Antes de evocar esta função, use a variável global ${MSE_GB_ARRAY_CONFIG} para
# conter todos os valores que você deseja que sejam salvos.
#
# Note que TODO o array será sobrescrito com o novo valor indicado.
#
#   @param string $1
#   Nome do array que será alterado.
#
#   @param string $2
#   Arquivo onde a alteração será feita.
#
#   @example
#     setArrayConfiguration 'ARRAY_NAME' 'ARRAY_VALUES' '~/config.sh'
#
setArrayConfiguration() {
  if [ $# != 3 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 3 arguments"
  else
    if [ ! -f $3 ]; then
      errorAlert "${FUNCNAME[0]}" "especified file not found"
    else
      local mseArr=$1
      local mseSearch
      local mseNewFile
      local mseNewLine
      local mseHasConfigInLine

      #
      # Para cada linha do arquivo indicado
      while read line; do
        mseHasConfigInLine=0
        mseNewLine=$line"\n"

        #
        # Identifica se a linha atual possui alguma configuração para a
        # variável que deve ser alterada
        mseSearch="${mseArr}["

        if [[ "$line" == *"$mseSearch"* ]]; then
          mseNewLine=''

          #
          # Para cada chave a ser redefinida, identifica se a linha atual
          # possui alguma delas.
          for k in "${!MSE_GB_ARRAY_CONFIG[@]}"; do
            mseSearch="${mseArr}[${k}]"

            if [[ "$line" == *"$mseSearch"* ]]; then
              mseNewLine=${mseSearch}'="'${MSE_GB_ARRAY_CONFIG[$k]}'"'"\n"
            fi
          done
        fi


        mseNewFile+=$mseNewLine
      done < $2

      echo $mseNewFile
    fi
  fi
}
