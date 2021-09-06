#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e


# o dia que terminar os scripts daqui
# será possível seguir com um método de edição de fonte de forma segura para os motivos
# pretendidos
# http://nafe.sourceforge.net/



#
# Permite ativar/desativar o UTF-8 do seu terminal 'bash'.
#
#   @param string $1
#   Indique 'on' para ativar ou 'off' para desativar o UTF-8
#   do seu terminal.
#
#   @example
#     setUTF8 on
#     setUTF8 off
#
setTerminalUTF8() {
  if [ ".$1" == ".off" ] ; then
    printf "\033%%@"
    printf "UTF-8 off \n"
  else
    printf "\033%%G"
    printf "UTF-8 on \u2658 \n"
    # o caracter \u2658 deve aparecer como o cavalo do xadres
  fi

  printf "\n"
}



#
# Imprime na tela o caracter correspondente ao numero decimal indicado.
# Importante salientar que os caracteres impressos dependem das configurações de
# fonte do terminal além do fato de ele estar ou não preparado para UTF-8.
#
#   @param int $1
#   Valor inteiro entre >= 33 que será convertido no caracter correspondente
#
#   @param bool $2
#   Se omitido, ou se '0' irá retornar o valor convertido e adicionará uma linha
#   em branco após a impressão.
#   Se '1' retornará apenas o caracter.
#
#   @example
#     convertDecimalToChar "33"
#     char=$(convertDecimalToChar "33" 1)
#
#
convertDecimalToChar() {
  local mseREG='^[0-9]+$'
  if ! [[ $1 =~ $mseREG ]]; then
    errorAlert "${FUNCNAME[0]}" "argument 1 is not an integer"
  else
    if [ $1 -lt 33 ]; then
      errorAlert "${FUNCNAME[0]}" "argument 1 must be greater than 32"
    else
      local mseIsValid=1

      if [ $# == 2 ] && [ $2 != 0 ] && [ $2 != 1 ]; then
        mseIsValid=0
        errorAlert "${FUNCNAME[0]}" "argument 2 must be boolean [ 0 | 1 ]"
      fi

      if [ $mseIsValid == 1 ]; then
        printf '%02x' $1 | xxd -p -r | iconv -f 'CP437//' -t 'UTF-8' | sed 's/.*/&  /'

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



#
# Imprime na tela o número decimal correspondente ao caracter indicado.
#
#   @param char $1
#   Caracter que será convertido para decimal.
#
#   @param bool $2
#   Se omitido, ou se '0' irá retornar o valor convertido e adicionará uma linha
#   em branco após a impressão.
#   Se '1' retornará apenas o número.
#
#   @example
#     convertCharToDecimal "!"
#     dec=$(convertCharToDecimal "!" 1)
#
#
convertCharToDecimal() {
  local mseIsValid=1

  if [ $# == 2 ] && [ $2 != 0 ] && [ $2 != 1 ]; then
    mseIsValid=0
    errorAlert "${FUNCNAME[0]}" "argument 2 must be boolean [ 0 | 1 ]"
  fi

  if [ $mseIsValid == 1 ]; then
    printf '%d' "'$1"

    if [ $# == 1 ]; then
      printf "\n"
    else
      if [ $# == 2 ] && [ $2 == 0 ]; then
        printf "\n"
      fi
    fi
  fi
}



#
# Imprime na tela o código hexadecimal UTF-8 correspondente ao caracter indicado.
#
#   @param char $1
#   Caracter que terá seu código hexadecimal UTF-8 impresso.
#
#   @param bool $2
#   Se omitido, ou se '0' irá retornar o código em formato texto e adicionará uma linha
#   em branco após a impressão.
#   Se '1' retornará apenas o código em formato texto.
#
#   @example
#     convertCharToHexUTF8 "ü"  # \bcc3
#
convertCharToHexUTF8() {
  if [ $# == 0 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else
    local i
    local mseRawCode=$(echo $1 | hexdump | head -1)
    local mseArrCode=(${mseRawCode// / })

    local mseLength="${#mseArrCode[@]}"
    local mseMinParts=2
    local mseDecCode='error'



    #
    # Para caracteres dentro da tabela ascii (entre 0 e 127) é esperado
    # que as operações acima retornem 2 partes no array ${mseArrCode}.
    #
    # Para caracteres acima da posição 127 são esperados ao menos 3 partes
    # onde, a última deve ser desprezada para fins de retorno.
    #
    local mseDec=$(convertCharToDecimal $1 1)
    if [ $mseDec -gt 127 ]; then
      mseLength=$((mseLength - 1))
    fi


    if [ $mseLength -ge $mseMinParts ]; then
      mseIsValid=1
      mseDecCode=''

      for (( i=1; i<mseLength; i++)); do
        mseDecCode+='\\'"${mseArrCode[$i]}"
      done
    fi


    printf "${mseDecCode}"
    if [ $# == 1 ]; then
      printf "\n"
    else
      if [ $# == 2 ] && [ $2 == 0 ]; then
        printf "\n"
      fi
    fi
  fi
}



#
# Imprime na tela o código octal UTF-8 correspondente ao caracter indicado.
#
#   @param char $1
#   Caracter que terá seu código octal UTF-8 impresso.
#
#   @param bool $2
#   Se omitido, ou se '0' irá retornar o código em formato texto e adicionará uma linha
#   em branco após a impressão.
#   Se '1' retornará apenas o código em formato texto.
#
#   @example
#     convertCharToOctalUTF8 "ü"  # \303\274
#
convertCharToOctalUTF8() {
  if [ $# == 0 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else
    local i
    local mseRawCode=$(echo $1 | hexdump -b | head -1)
    local mseArrCode=(${mseRawCode// / })

    local mseLength="${#mseArrCode[@]}"
    local mseMinParts=3
    local mseDecCode='error'


    if [ $mseLength -ge $mseMinParts ]; then
      mseIsValid=1
      mseDecCode=''

      for (( i=1; i<(mseLength - 1); i++)); do
        mseDecCode+='\\'"${mseArrCode[$i]}"
      done
    fi


    printf "${mseDecCode}"
    if [ $# == 1 ]; then
      printf "\n"
    else
      if [ $# == 2 ] && [ $2 == 0 ]; then
        printf "\n"
      fi
    fi
  fi
}










#
# Imprime os 256 caracteres presentes na atual fonte do seu terminal
#
#   @param string $1
#   Se omitido, ou se 'table' irá retornar a tabela com todos os marcadores de cabeçalho
#   e demais separadores visuais.
#
#   Se 'char', irá retornar apenas a lista de cada caracter, 1 a 1, separados por um
#   único espaço e onde cada linhas terá ao todo 16 itens. Nenhum adorno será adicionado.
#
#   Se 'code', irá retornar uma tabela onde, em cada linha constará os códigos usados
#   para as diferentes codificações do mesmo caracter. Este caso facilmente ocupará muitas
#   linhas e para facilitar a leitura é possível usar os próximos parâmetros.
#
#   @param int $2
#   Número inteiro (a partir de 33) que indica de qual ítem a lista gerada na opção 'code'
#   deve iniciar
#
#   @param int $3
#   Número inteiro (até 255) que indica o último ítem a ser mostrado quando está sendo usada
#   a opção 'code'.
#
#   @example
#     printTerminalCharTable 'code' 50 70
#
printTerminalCharTable() {
  local mseOutputType='table'
  local mseIniCode=33
  local mseEndCode=255
  local mseIsValid=1


  if [ $# -ge 1 ]; then
    if [ $1 != "table" ] && [ $1 != "char" ] && [ $1 != "code" ]; then
      mseIsValid=0
      errorAlert "${FUNCNAME[0]}" "argument 1 only accepts values 'table', 'char' or 'code'"
    else
      mseOutputType=$1
    fi


    if [ $mseIsValid == 1 ] && [ $mseOutputType == "code" ] && [ $# -ge 2 ]; then
      local mseREG='^[0-9]+$'

      if ! [[ $2 =~ $mseREG ]]; then
        mseIsValid=0
        errorAlert "${FUNCNAME[0]}" "argument 2 is not an integer"
      else
        if [ $2 -le 32 ]; then
          mseIsValid=0
          errorAlert "${FUNCNAME[0]}" "argument 2 must be greater than 32"
        else
          mseIniCode=$2
        fi
      fi


      if [ $mseIsValid == 1 ] && [ $# -ge 3 ]; then

        if ! [[ $3 =~ $mseREG ]]; then
          mseIsValid=0
          errorAlert "${FUNCNAME[0]}" "argument 3 is not an integer"
        else
          if [ $3 -lt 33 ] || [ $3 -gt 255 ]; then
            mseIsValid=0
            errorAlert "${FUNCNAME[0]}" "argument 3 must be between 33 and 255"
          else
            if [ $2 -gt $3 ]; then
              mseIsValid=0
              errorAlert "${FUNCNAME[0]}" "argument 2 cannot be granther than argument 3"
            else
              mseEndCode=$3
            fi
          fi
        fi
      fi
    fi
  fi


  if [ $mseIsValid == 1 ]; then

    if [ $mseOutputType == "table" ] || [ $mseOutputType == "char" ]; then

      #
      # 'table' : imprime o cabeçalho com os índices hexadecimais de 0-f
      if [ $mseOutputType == "table" ]; then
        printf "\n      ";
        for x in {0..15}; do
          printf "%-3x" $x;
        done;
        printf "\n%46s\n" | sed 's/ /-/g;s/^/      /';
      fi


      #
      # 'table' : usa as 2 primeiras linhas para representar os
      #           caracteres de controles
      if [ $mseOutputType == "table" ]; then
        c=$(echo "fa" | xxd -p -r | iconv -f 'CP437//' -t 'UTF-8')
        printf "%32s" | sed 's/../'"$c"'  /g;s/^/  0   /;s/$/\n/'
        printf "%32s" | sed 's/../'"$c"'  /g;s/^/  1   /'
      fi



      #
      # passa por todos os códigos entre o decimal 32 e o 255
      # efetuando a conversão deles para 'codepage 437'
      for x in {32..255}; do
        #
        # Sempre que o módulo de 16=0 irá adicionar uma quebra de linha.
        (( x % 16 == 0 )) && printf "\n"


        #
        # 'table' : imprime os índices hexadecimais laterais 0-f
        if [ $mseOutputType == "table" ]; then
          let "n = x % 15"
          (( (x % 16) == 0 )) && printf "%-4x" $n | sed 's/0/f/;s/^/  /'
        fi


        #
        # Converte o inteiro para o simbolo correspondente
        printf "%02x" $x | xxd -p -r | iconv -f 'CP437//' -t 'UTF-8' | sed 's/.*/&  /'


        #
        # 'table' : imprime uma linha separadora entre os caracteres ascii [0-127]
        #           e os demais [128-255]
        if [ $mseOutputType == "table" ]; then
          (( x == 127 )) && printf "%46s" | sed 's/ /-/g;s/^/      /;i\ '
        fi
      done


      #
      # 'table' : imprime o rodapé com os índices hexadecimais de 0-f
      if [ $mseOutputType == "table" ]; then
        printf "%46s" | sed 's/ /-/g;s/^/\n      /;s/$/\n      /'; # div line
        for x in {0..15}; do
          printf "%-3x" $x;
        done;
      fi

      printf "\n"

    else

      local i
      local mseLine
      local mseRawTable

      local mseChar
      local mseCDecimal
      local mseCHexUTF8
      local mseCOctalUTF8

      for (( i=mseIniCode; i<=mseEndCode; i++)); do
        mseChar=$(convertDecimalToChar $i 1)

        if [ $i == 42 ]; then
          mseRawTable+='* 42 \\0a2a \\052'"\n"
        else
          mseCDecimal=$i
          mseCHexUTF8=$(convertCharToHexUTF8 $mseChar 1)
          mseCOctalUTF8=$(convertCharToOctalUTF8 $mseChar 1)

          if [ $mseChar == '%' ]; then
            mseChar='%%'
          fi

          mseLine=$(printf '%s %s %s %s' $mseChar $mseCDecimal $mseCHexUTF8 $mseCOctalUTF8)
          mseRawTable+=$mseLine"\n"
        fi
      done

      printf "\n"
      mseRawTable=$(printf "${mseRawTable}")
      column -e -t -o "  " -N "Char,Decimal,Hex UTF8,Octal UTF8" <<< "${mseRawTable}"
      printf "\n"

    fi
  fi
}
