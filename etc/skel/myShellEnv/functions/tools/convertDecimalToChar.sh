#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Converte o valor Decimal informado para o respectivo Caracter.
#
# Use múltiplos decimais separados por espaços para representar caracteres
# multibyte.
#
# Importante salientar que os caracteres correspondentes aos decimais acima do
# número 127 dependem da fonte sendo usada no terminal e no fato de ele estar
# ou não preparado para usar caracteres UTF-8.
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
#     convertDecimalToChar "195 173"    # converte para -> í
#     hex=$(convertDecimalToChar "195 173" 1)
#
convertDecimalToChar() {

  if [ $# != 1 ] && [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else
    local i
    local mseIsValid=1
    local mseRawDec=(${1// / })
    local mseChar


    #
    # verifica cada um dos decimais apresentados identificando se
    # são válidos
    local mseREG='^[0-9]+$'
    for (( i=0; i<${#mseRawDec}; i++ )); do
      if [ $mseIsValid == 1 ]; then
        if ! [[ ${mseRawDec[$i]} =~ $mseREG ]]; then
          mseIsValid=0
          errorAlert "${FUNCNAME[0]}" "argument 1 is not an valid decimal"
        fi
      fi
    done


    if [ $mseIsValid == 1 ]; then
      local mseRawOctal=''

      #
      # Converte cada um dos decimais apresentados
      # em seu correspondente octal
      for (( i=0; i<${#mseRawDec}; i++ )); do
        if [ "$i" != "0" ]; then
          mseRawOctal+=' '
        fi

        mseRawOctal+='\\'
        mseRawOctal+=$(convertDecimalToOctal ${mseRawDec[$i]})
      done
    fi

    printf $mseRawOctal



    #local mseREG='^[0-9]+$'
    #if ! [[ $1 =~ $mseREG ]]; then
    #  errorAlert "${FUNCNAME[0]}" "argument 1 is not an valid decimal"
    #else
    #  if [ $1 -lt 33 ]; then
    #    errorAlert "${FUNCNAME[0]}" "argument 1 must be greater than 32"
    #  else

        #
        # Efetivamente converte o valor e imprime ele na tela.
    #    printf '%02x' $1 | xxd -p -r | iconv -f 'CP437//' -t 'UTF-8'


        #
        # Adiciona o caracter de 'nova linha' caso necessário
    #    if [ $# == 1 ]; then
    #      printf "\n"
    #    else
    #      if [ $# == 2 ] && [ $2 == 0 ]; then
    #        printf "\n"
    #      fi
    #    fi
    #  fi
    #fi
  fi
}
