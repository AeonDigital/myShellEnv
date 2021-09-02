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
# 'P' indica 'Prompt; para uso na construção de prompts'
#

NONE='\e[40;00m'
#PNONE='\[\e[00m\]'

BLACK='\e[40;00;30m'
#PBLACK='\[\e[40;00;30m\]'

DGREY='\e[40;01;30m'
#PDGREY='\[\e[40;01;30m\]'

WHITE='\e[40;00;37m'
#PWHITE='\[\e[40;00;37m\]'

SILVER='\e[40;01;37m'
#PSILVER='\[\e[40;01;37m\]'

RED='\e[40;00;31m'
#PRED='\[\e[40;00;31m\]'

LRED='\e[40;01;31m'
#PLRED='\[\e[40;01;31m\]'

GREEN='\e[40;00;32m'
#PGREEN='\[\e[40;00;32m\]'

LGREEN='\e[40;01;32m'
#PLGREEN='\[\e[40;01;32m\]'

BROWN='\e[40;00;33m'
#PBROWN='\[\e[40;00;33m\]'

YELLOW='\e[40;01;33m'
#PYELLOW='\[\e[40;01;33m\]'

BLUE='\e[40;00;34m'
#PBLUE='\[\e[40;00;34m\]'

LBLUE='\e[40;01;34m'
#PLBLUE='\[\e[40;01;34m\]'

PURPLE='\e[40;00;35m'
#PPURPLE='\[\e[40;00;35m\]'

LPURPLE='\e[40;01;35m'
#PLPURPLE='\[\e[40;01;35m\]'

CYAN='\e[40;00;36m'
#PCYAN='\[\e[40;00;36m\]'

LCYAN='\e[40;01;36m'
#PLCYAN='\[\e[40;01;36m\]'



# Atributo de fonte
BOLD='\e[01m'
UNDERLINE='\e[03m'
BLINK='\e[05m'
