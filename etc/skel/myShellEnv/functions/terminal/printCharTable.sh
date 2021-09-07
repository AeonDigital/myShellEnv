#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Imprime os 256 caracteres presentes na atual fonte do seu terminal.
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
#   Usado apenas se $1='code'
#   Número inteiro (a partir de 33) que indica de qual ítem a lista gerada na opção 'code'
#   deve iniciar.
#
#   @param int $3
#   Usado apenas se $1='code'
#   Número inteiro (até 255) que indica o último ítem a ser mostrado quando está sendo usada
#   a opção 'code'.
#
#   @example
#     printCharTable 'code' 50 70
#
printCharTable() {
  local mseOutputType='table'
  local mseIniCode=33
  local mseEndCode=255
  local mseIsValid=1


  #
  # Valida os valores dos argumentos passados.
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



  #
  # se os argumentos passados são válidos
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

      for (( i=mseIniCode; i<=mseEndCode; i++ )); do
        mseChar=$(printf "%02x" $i | xxd -p -r | iconv -f 'CP437//' -t 'UTF-8')
        mseCDecimal=$(convertCharToDecimal $mseChar 1)
        mseCHexUTF8=$(convertCharToHex $mseChar 1)
        mseCOctalUTF8=$(convertCharToOctal $mseChar 1)

        if [ $i == 37 ]; then
          mseLine='%:37:25:045'
        elif [ $i == 42 ]; then
          mseLine='*:42:2A:052'
        elif [ $i == 58 ]; then
          mseLine='-:45:3A:072'
        else
          mseLine=$(printf '%s:%s:%s:%s' $mseChar $mseCDecimal $mseCHexUTF8 $mseCOctalUTF8)
        fi

        mseRawTable+=$mseLine"\n"
      done

      printf "\n"
      mseRawTable=$(printf "${mseRawTable}")
      column -e -t -s ":" -o "  " -N "Char,Decimal,Hex,Octal" <<< "${mseRawTable}"
      printf "\n"

    fi
  fi
}
