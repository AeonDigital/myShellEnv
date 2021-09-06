#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Converte o valor Char informado para o respectivo Decimal.
#
# Caracteres multibyte retornarão mais de um decimal, cada qual representando um
# de seus bytes.
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
#     convertCharToDecimal "í"    # converte para -> "195 173"
#     hex=$(convertCharToDecimal "í" 1)
#
convertCharToDecimal() {

  if [ $# != 1 ] && [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else
    local i
    local c
    local mseStr=$1


    #
    # Desmembra strings multibytes em seus bytes componentes e após
    # converte o valor de cada um.
    for (( i=0; i<${#mseStr}; i++ )); do
      c="${mseStr:$i:1}"

      printf '%i' "'$c"
      if [ "$i" != "0" ]; then
        printf ' '
      fi
    done


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
}
