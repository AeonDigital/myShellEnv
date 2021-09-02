#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Variáveis que carregam as definição de cores que
# podem ser usadas em mensagens de textos
#
# 'D' indica 'Dark'
# 'L' indica 'Light'
#

NONE='\e[40;00m'

BLACK='\e[40;00;30m'
DGREY='\e[40;01;30m'
WHITE='\e[40;00;37m'
SILVER='\e[40;01;37m'

RED='\e[40;00;31m'
LRED='\e[40;01;31m'

GREEN='\e[40;00;32m'
LGREEN='\e[40;01;32m'

BROWN='\e[40;00;33m'
YELLOW='\e[40;01;33m'

BLUE='\e[40;00;34m'
LBLUE='\e[40;01;34m'

PURPLE='\e[40;00;35m'
LPURPLE='\e[40;01;35m'

CYAN='\e[40;00;36m'
LCYAN='\e[40;01;36m'



MSE_GB_AVAILABLE_COLORS_RAW=(
  "NONE"
  "BLACK" "DGREY" "WHITE" "SILVER" "RED" "LRED"
  "GREEN" "LGREEN" "BROWN" "YELLOW" "BLUE" "LBLUE"
  "PURPLE" "LPURPLE" "CYAN" "LCYAN"
)


MSE_GB_AVAILABLE_COLOR_NAMES=(
  "Normal"
  "Preto" "Cinza escuro" "Branco" "Prata" "Vermelho" "Vermelho claro"
  "Verde" "Verde claro" "Marrom" "Amarelo" "Azul" "Azul claro"
  "Purpura" "Purpura claro" "Ciano" "Ciano claro"
)


# Atributo de fonte
BOLD='\e[01m'
UNDERLINE='\e[03m'
BLINK='\e[05m'
