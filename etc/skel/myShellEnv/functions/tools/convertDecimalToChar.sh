#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Converte o valor Decimal informado para o respectivo Caracter.
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
#     convertDecimalToChar "161"    # converte para -> í
#     hex=$(convertDecimalToChar "161" 1)
#
convertDecimalToChar() {

  if [ $# != 1 ] && [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else
    local mseREG='^[0-9]+$'
    if ! [[ $1 =~ $mseREG ]]; then
      errorAlert "${FUNCNAME[0]}" "argument 1 is not an valid decimal"
    else
      if [ $1 -lt 33 ]; then
        errorAlert "${FUNCNAME[0]}" "argument 1 must be greater than 32"
      else

        #
        # Efetivamente converte o valor e imprime ele na tela.
        printf '%02x' $1 | xxd -p -r | iconv -f 'CP437//' -t 'UTF-8'


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
  fi
}
