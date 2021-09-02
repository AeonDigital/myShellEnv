#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Mostra as cores básicas disponíveis no shell
# que podem ser utilizadas para a estilização das mensagens
# de interface.
#
#   @param int $1
#   Use '0' ou omita este parametro se quiser ver a tabela completa
#   Use '1' para ver apenas as colunas que possuem referências de nome e exemplos
#   das cores.
#   Use '2' para ver apenas as colunas de código das cores e seus respectivos
#   resultados.
#
#   @exemple
#     showTextColors
#
showTextColors() {

  local i
  local mseLength=${#MSE_GB_AVAILABLE_COLORS_RAW[@]}
  local mseRawTable=""
  local mseColorName=""
  local mseColorRaw=""
  local mseColorCod=""
  local mseLine=""


  for (( i=0; i<mseLength; i++)); do
    mseColorName=${MSE_GB_AVAILABLE_COLOR_NAMES[$i]}
    mseColorRaw=${MSE_GB_AVAILABLE_COLORS_RAW[$i]}
    mseColorCod="\\${!mseColorRaw}"

    mseLine="${mseColorName}:${mseColorRaw}:${mseColorCod}:${!mseColorRaw}myShellEnv${NONE} \n"
    mseRawTable+="${mseLine}"
  done

  printf "\n\n${SILVER}As seguintes opções de cores estão disponíveis:${NONE} \n\n"

  mseRawTable=$(printf "${mseRawTable}")
  mseRawTable=$(sed 's/^\s*//g' <<< "${mseRawTable}" | sed 's/\s*$//g' | sed 's/\s*:/:/g' | sed 's/:\s*/:/g')

  if [ $# == 0 ] || [ $1 == 0 ]; then
    column -e -t -s ":" -o " | " -N "Cor,Raw,Variavel,Aparencia" <<< "${mseRawTable}"
  else
    if [ $1 == 1 ]; then
      column -e -t -s ":" -o " | " -N "Cor,Raw,Variavel,Aparencia" -H "Variavel" <<< "${mseRawTable}"
    fi
    if [ $1 == 2 ]; then
      column -e -t -s ":" -o " | " -N "Cor,Raw,Variavel,Aparencia" -H "Cor,Variavel" <<< "${mseRawTable}"
    fi
  fi

  printf "\nDica:"
  printf "Use o 'grep' caso precise filtrar os resultados: \n"
  printf "  Ex: showTextColors | grep -in 'azul' \n"
  printf "\n"
}
