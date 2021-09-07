#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Converte o valor Decimal informado para o respectivo Hexadecimal (base 16).
#
# Use múltiplos valores separados por espaços se quiser converter mais de
# um ao mesmo tempo.
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
#     convertDecimalToHex "161"       # converte para -> A1
#     convertDecimalToHex "195 173"   # converte para -> "C3 AD"
#     result=$(convertDecimalToHex "161" 1)
#
convertDecimalToHex() {

  if [ $# != 1 ] && [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else
    local i
    local mseIsValid=1
    local mseArrParam=(${1// / })
    local mseRawOutput
    local mseTmp


    #
    # verifica cada um dos decimais apresentados identificando se
    # são válidos
    local mseREG='^[0-9]+$'
    for (( i=0; i<${#mseArrParam[@]}; i++ )); do
      if [ $mseIsValid == 1 ]; then
        if ! [[ ${mseArrParam[$i]} =~ $mseREG ]]; then
          mseIsValid=0
          errorAlert "${FUNCNAME[0]}" "argument 1 is not an valid decimal"
        fi
      fi
    done


    if [ $mseIsValid == 1 ]; then

      #
      # Converte cada um dos decimais apresentados
      for (( i=0; i<${#mseArrParam[@]}; i++ )); do
        if [ "$i" != "0" ]; then
          mseRawOutput+='-'
        fi

        mseTmp=$(printf '%X' ${mseArrParam[$i]})
        mseRawOutput+="${mseTmp}"
      done

      printf $mseRawOutput | sed 's/-/ /g'

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
