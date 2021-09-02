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


  for (( i=0; i<mseLength; i++)); do
    mseColorName=${MSE_GB_AVAILABLE_COLOR_NAMES[$i]}
    mseColorRaw=${MSE_GB_AVAILABLE_COLORS_RAW[$i]}
    mseColorCod="\\${!mseColorRaw}"

    mseRawTable="${mseRawTable}${mseColorName}:${mseColorRaw}:${mseColorCod}:${!mseColorRaw}myShellEnv${NONE} \n"
  done

  ' :
  local mseRawTable=$(printf "
    Normal:         NONE:     \\\\e[40;00m:    ${NONE}myShellEnv \n
    Preto:          BLACK:    \\\\e[40;00;30m: ${BLACK}myShellEnv${NONE} \n
    Cinza escuro:   DGREY:    \\\\e[40;01;30m: ${DGREY}myShellEnv${NONE} \n
    Branco:         WHITE:    \\\\e[40;00;37m: ${WHITE}myShellEnv${NONE} \n
    Prata:          SILVER:   \\\\e[40;01;37m: ${SILVER}myShellEnv${NONE} \n
    Vermelho:       RED:      \\\\e[40;00;31m: ${RED}myShellEnv${NONE} \n
    Vermelho claro: LRED:     \\\\e[40;01;31m: ${LRED}myShellEnv${NONE} \n
    Verde:          GREEN:    \\\\e[40;00;32m: ${GREEN}myShellEnv${NONE} \n
    Verde claro:    LGREEN:   \\\\e[40;01;32m: ${LGREEN}myShellEnv${NONE} \n

    Marrom:         BROWN:    \\\\e[40;00;33m: ${BROWN}myShellEnv${NONE} \n
    Amarelo:        YELLOW:   \\\\e[40;01;33m: ${YELLOW}myShellEnv${NONE} \n
    Azul:           BLUE:     \\\\e[40;00;34m: ${BLUE}myShellEnv${NONE} \n
    Azul claro:     LBLUE:    \\\\e[40;01;34m: ${LBLUE}myShellEnv${NONE} \n
    Purpura:        PURPLE:   \\\\e[40;00;35m: ${PURPLE}myShellEnv${NONE} \n
    Purpura claro:  LPURPLE:  \\\\e[40;01;35m: ${LPURPLE}myShellEnv${NONE} \n
    Ciano:          CYAN:     \\\\e[40;00;36m: ${CYAN}myShellEnv${NONE} \n
    Ciano claro:    LCYAN:    \\\\e[40;01;36m: ${LCYAN}myShellEnv${NONE} \n
  ")
  '

  printf "\n\n${SILVER}As seguintes opções de cores estão disponíveis:${NONE} \n\n"
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
