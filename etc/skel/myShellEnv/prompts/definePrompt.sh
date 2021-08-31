#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
#
PROMPT_STYLE='SIMPLE'
PROMPT_STYLEI=0
PROMPT_COLOR_SYMBOLS='WHITE'
PROMPT_COLOR_USERNAME='DGREY'
PROMPT_COLOR_DIRECTORY='DGREY'

PROMPT_AVAILABLE_STYLE_NAME=()
PROMPT_AVAILABLE_STYLE_FORMAT=()
PROMPT_AVAILABLE_SQUEMA=()


#
# Estilo simples
PROMPT_AVAILABLE_STYLE_NAME[0]="SIMPLE"
PROMPT_AVAILABLE_STYLE_FORMAT[0]="${NONE}$ username@host : _"
PROMPT_AVAILABLE_SQUEMA[0]='\[\e[40;[[SYMBOL]]\]\$ \[\e[40;[[USERNAME]]\]\u\[\e[40;[[SYMBOL]]\]@\[\e[40;[[USERNAME]]\]\h\[\e[40;[[SYMBOL]]\] :\[\e[40;[[NONE]]\] '

#
# Estilo 'Nova linha 01'
PROMPT_AVAILABLE_STYLE_NAME[1]="NEWLINE01"
PROMPT_AVAILABLE_STYLE_FORMAT[1]="${NONE}\$ username@host in ~/atual/directory/path \n> _"
PROMPT_AVAILABLE_SQUEMA[1]='\[\e[40;[[SYMBOL]]\]\$ \[\e[40;[[USERNAME]]\]\u\[\e[40;[[SYMBOL]]\]@\[\e[40;[[USERNAME]]\]\h\[\e[40;[[SYMBOL]]\] in \[\e[40;[[DIRECTORY]]\]\w \n\076\[\e[40;[[NONE]]\] '

#
# Estilo 'Nova linha 02'
PROMPT_AVAILABLE_STYLE_NAME[2]="NEWLINE02"
PROMPT_AVAILABLE_STYLE_FORMAT[2]="${NONE}\342\224\214\342\224\200\342\224\200 \$ username@host in ~/atual/directory/path \n\342\224\224\342\224\200\342\225\274 _"
PROMPT_AVAILABLE_SQUEMA[2]='\[\e[40;[[DIRECTORY]]\]\342\224\214\342\224\200\342\224\200 \[\e[40;[[SYMBOL]]\]\$ \[\e[40;[[USERNAME]]\]\u\[\e[40;[[SYMBOL]]\]@\[\e[40;[[USERNAME]]\]\h\[\e[40;[[SYMBOL]]\] in \[\e[40;[[DIRECTORY]]\]\w \n\[\e[40;[[DIRECTORY]]\]\342\224\224\342\224\200\076\[\e[40;[[NONE]]\] '

#
# Estilo 'Nova linha 03'
PROMPT_AVAILABLE_STYLE_NAME[3]="NEWLINE03"
PROMPT_AVAILABLE_STYLE_FORMAT[3]="${NONE}\342\224\214\342\224\200\342\224\200 \$ username@host in ~/atual/directory/path \n\342\224\224\342\224\200\076 _"
PROMPT_AVAILABLE_SQUEMA[3]='\[\e[40;[[DIRECTORY]]\]\342\224\214\342\224\200\342\224\200 \[\e[40;[[SYMBOL]]\]\$ \[\e[40;[[USERNAME]]\]\u\[\e[40;[[SYMBOL]]\]@\[\e[40;[[USERNAME]]\]\h\[\e[40;[[SYMBOL]]\] in \[\e[40;[[DIRECTORY]]\]\w \n\[\e[40;[[DIRECTORY]]\]\342\224\224\342\225\274\[\e[40;[[NONE]]\] '




*
* Mostra os prompts que estão aptos a serem usados pelo usuário
*
showPromptStyles() {
  printf "\n\n${SILVER}Os seguintes estilos de prompts podem ser usados:${NONE}\n\n"
  l=${#PROMPT_AVAILABLE_STYLE_NAME[@]}

  for (( i=0; i<l; i++)); do
    printf "${LBLUE}${PROMPT_AVAILABLE_STYLE_NAME[$i]}: \n"
    printf "${PROMPT_AVAILABLE_STYLE_FORMAT[$i]} \n\n"
  done

  printf "\n"
}

#
# Mostra as cores disponíveis para estilização do prompt.
# Tratam-se das mesmas cores usadas para a estilização de textos.
#
showPromptColors() {
  showTextColors
}

#
# Mostra as configurações atualmente selecionadas para a
# amostragem do prompt.
#
showPromptConfiguration() {
  printf "\n\n${SILVER}As seguintes configurações estão definidas para o prompt${NONE}\n\n"
  printf "     ${LBLUE}STYLE${NONE}: ${PROMPT_STYLE}\n"
  printf "   ${LBLUE}SYMBOLS${NONE}: ${PROMPT_COLOR_SYMBOLS}\n"
  printf "  ${LBLUE}USERNAME${NONE}: ${PROMPT_COLOR_USERNAME}\n"
  printf " ${LBLUE}DIRECTORY${NONE}: ${PROMPT_COLOR_DIRECTORY}\n\n"
}

#
# Define o tipo do prompt que será usado.
# Não efetua alterações até que o comando 'redefinePrompt' seja executado.
#
#   @param string $1
#   Estilo do prompt a ser usado.
#
#   @example
#     selectPromptStyle SIMPLE
#
selectPromptStyle() {
  if [ $# != 1 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 arguments"
  else
    ISVALID=0
    COUNTER=0

    for style in "${PROMPT_AVAILABLE_STYLE_NAME[@]}"; do
      if [ $1 == $style ]; then
        ISVALID=1
        PROMPT_STYLE=$style
        PROMPT_STYLEI=$COUNTER
      fi
      COUNTER="$((COUNTER + 1))"
    done

    if [ $ISVALID == 0 ]; then
      errorAlert "${FUNCNAME[0]}" "invalid argument"
    fi
  fi
}

#
# Define as cores a serem usadas no prompt.
# Todos os parametros são opcionais e todo aquele que for omitido ou inválido
# terá seu valor definido como 'WHITE'.
#
#   @param string $1
#   Cor para os simbolos '$', '@', ':' e a particula 'in'
#   que precede o local em que o usuário está no momento.
#
#   @param string $2
#   Cor para as informações 'user' e 'host'.
#
#   @param string $3
#   Cor para o diretório em que o usuário está no momento.
#   Também será usada para as 'ligações' especiais quando o estilo
#   for multilinhas.
#
#   @example
#     selectPromptColors "LPURPLE" "DGRAY"
#
selectPromptColors() {
  SYMBOLS='WHITE'
  USERNAME='WHITE'
  DIRECTORY='WHITE'

  ACOLORS=(
    "BLACK" "DGREY" "WHITE" "SILVER" "RED" "LRED"
    "GREEN" "LGREEN" "BROWN" "YELLOW" "BLUE" "LBLUE"
    "PURPLE" "LPURPLE" "CYAN" "LCYAN"
  )

  if [ $# >= 1 ]; then
    for color in "${ACOLORS[@]}"; do
      if [ $1 == $color ]; then
        SYMBOLS=$color
      fi
    done
  fi

  if [ $# >= 2 ]; then
    for color in "${ACOLORS[@]}"; do
      if [ $2 == $color ]; then
        USERNAME=$color
      fi
    done
  fi

  if [ $# >= 3 ]; then
    for color in "${ACOLORS[@]}"; do
      if [ $3 == $color ]; then
        DIRECTORY=$color
      fi
    done
  fi


  PROMPT_COLOR_SYMBOLS=$SYMBOLS
  PROMPT_COLOR_USERNAME=$USERNAME
  PROMPT_COLOR_DIRECTORY=$DIRECTORY
}

#
# Baseado nas seleções feitas e que estão armazenadas nas variáveis
# de controle, monta o prompt conforme ele deve aparecer e mostra para o usuário.
#
previewPrompt() {
  PSQUEMA=${PROMPT_AVAILABLE_SQUEMA[$PROMPT_STYLEI]}
  PSQUEMA="$(echo $PSQUEMA | sed -e 's/\\\[\\e\[40;/\\e\[/g' | sed -e 's/\]\]\\\]/\]\]/g')"



  NEW="${RNONE}"
  REG='s/\[\[NONE\]\]/'"$NEW"'/g'
  PSQUEMA="$(echo $PSQUEMA | sed -e ${REG})"



  TMP="R${PROMPT_COLOR_SYMBOLS}"
  NEW="${!TMP}"
  REG='s/\[\[SYMBOL\]\]/'"$NEW"'/g'
  PSQUEMA="$(echo $PSQUEMA | sed -e ${REG})"

  TMP="R${PROMPT_COLOR_USERNAME}"
  NEW="${!TMP}"
  REG='s/\[\[USERNAME\]\]/'"$NEW"'/g'
  PSQUEMA="$(echo $PSQUEMA | sed -e ${REG})"

  TMP="R${PROMPT_COLOR_DIRECTORY}"
  NEW="${!TMP}"
  REG='s/\[\[DIRECTORY\]\]/'"$NEW"'/g'
  PSQUEMA="$(echo $PSQUEMA | sed -e ${REG})"


  REG='s/\\\$/\$/g'
  PSQUEMA="$(echo $PSQUEMA | sed -e ${REG})"

  REG='s/\\u/'"$USER"'/g'
  PSQUEMA="$(echo $PSQUEMA | sed -e ${REG})"

  HOSTNAME=`uname -n`
  REG='s/\\h/'"$HOSTNAME"'/g'
  PSQUEMA="$(echo $PSQUEMA | sed -e ${REG})"

  DIRECTORY="\/etc\/skel\/myShellEnv"
  REG='s/\\w/'"$DIRECTORY"'/g'
  PSQUEMA="$(echo $PSQUEMA | sed -e ${REG})"


  printf "\n\n${SILVER}Resultado da configuração do prompt: ${NONE}"
  printf "\n${LBLUE}...${NONE} \n":
  printf "${PSQUEMA}\n"
  printf "\n${LBLUE}...${NONE} \n\n"
}
