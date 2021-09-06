#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Converte o valor Octal informado para o respectivo Char.
#
#   @param int $1
#   Valor que será convertido.
#
#   @param bool $2
#   Se omitido, ou se '0' irá retornar o valor convertido e adicionará uma linha
#   em branco após a impressão.
#   Se '1' retornará apenas o caracter.
#
#   @example
#     convertOctalToChar "195 173"    # converte para -> í
#     hex=$(convertOctalToChar "241" 1)
#
convertOctalToChar() {

  if [ $# != 1 ] && [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else
    local mseREG='^[0-7]+$'
    if ! [[ $1 =~ $mseREG ]]; then
      errorAlert "${FUNCNAME[0]}" "argument 1 is not an valid octal"
    else

      #
      # Efetivamente converte o valor e imprime ele na tela.
      local val=$(echo $((16#$1)))
      printf "$val"

      #
      # Adiciona o caracter de 'nova linha' caso necessário
      if [ $# == 1 ]; then
        printf "\n"
      else
        if [ $# == 2 ] && [ $2 == 0 ]; then
          printf "\n"
        fi
      fi

    fi
  fi
}
