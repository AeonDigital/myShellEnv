#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Mostra as cores básicas disponíveis no shell
# que podem ser utilizadas para a estilização das mensagens
# de interface.
#
#   @example
#     showTextColors
#
showTextColors() {

  COLOR_TEXT=$(printf "
    Normal:         NONE:     \\\\e[00m:    ${NONE}myShellEnv \n
    Preto:          BLACK:    \\\\e[00;30m: ${BLACK}myShellEnv${NONE} \n
    Cinza escuro:   DGREY:    \\\\e[01;30m: ${DGREY}myShellEnv${NONE} \n
    Branco:         WHITE:    \\\\e[00;37m: ${WHITE}myShellEnv${NONE} \n
    Prata:          SILVER:   \\\\e[01;37m: ${SILVER}myShellEnv${NONE} \n
    Vermelho:       RED:      \\\\e[00;31m: ${RED}myShellEnv${NONE} \n
    Vermelho claro: LRED:     \\\\e[01;31m: ${LRED}myShellEnv${NONE} \n
    Verde:          GREEN:    \\\\e[00;32m: ${GREEN}myShellEnv${NONE} \n
    Verde claro:    LGREEN:   \\\\e[01;32m: ${LGREEN}myShellEnv${NONE} \n

    Marrom:         BROWN:    \\\\e[00;33m: ${BROWN}myShellEnv${NONE} \n
    Amarelo:        YELLOW:   \\\\e[01;33m: ${YELLOW}myShellEnv${NONE} \n
    Azul:           BLUE:     \\\\e[00;34m: ${BLUE}myShellEnv${NONE} \n
    Azul claro:     LBLUE:    \\\\e[01;34m: ${LBLUE}myShellEnv${NONE} \n
    Purpura:        PURPLE:   \\\\e[00;35m: ${PURPLE}myShellEnv${NONE} \n
    Purpura claro:  LPURPLE:  \\\\e[01;35m: ${LPURPLE}myShellEnv${NONE} \n
    Ciano:          CYAN:     \\\\e[00;36m: ${CYAN}myShellEnv${NONE} \n
    Ciano claro:    LCYAN:    \\\\e[01;36m: ${LCYAN}myShellEnv${NONE} \n
  ")

  printf "\nAs seguintes opções de cores estão disponíveis: \n\n"
  COLOR_TEXT=$(sed 's/^\s*//g' <<< "${COLOR_TEXT}" | sed 's/\s*$//g' | sed 's/\s*:/:/g' | sed 's/:\s*/:/g')
  column -s ":" -o " | " -t -N "Cor,Raw,Variavel,Aparencia" <<< "${COLOR_TEXT}"

  printf "\nDica:"
  printf "Use o 'grep' caso precise filtrar os resultados: \n"
  printf "  Ex: showTextColors | grep -in 'azul' \n"
  printf "\n"
}
