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





#
# Mostra os prompts que estão aptos a serem usados pelo usuário
#
showPromptStyles() {
  printf "\n\n${SILVER}Os seguintes estilos de prompts podem ser usados:${NONE}\n\n"
  mseLength=${#PROMPT_AVAILABLE_STYLE_NAME[@]}

  for (( i=0; i<mseLength; i++)); do
    printf "${LBLUE}${PROMPT_AVAILABLE_STYLE_NAME[$i]}: \n"
    printf "${PROMPT_AVAILABLE_STYLE_FORMAT[$i]} \n\n"
  done

  unset mseLength

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
    mseIsValid=0
    mseCounter=0
    mseUStyle=$(toUpperCase $1)

    for mseStyle in "${PROMPT_AVAILABLE_STYLE_NAME[@]}"; do
      if [ $mseUStyle == $mseStyle ]; then
        mseIsValid=1
        PROMPT_STYLE=$mseStyle
        PROMPT_STYLEI=$mseCounter
      fi
      mseCounter="$((mseCounter + 1))"
    done

    if [ $mseIsValid == 0 ]; then
      errorAlert "${FUNCNAME[0]}" "invalid argument"
    fi

    unset mseStyle
    unset mseCounter
    unset mseIsValid
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
  mseSYMBOLS='WHITE'
  mseUSERNAME='WHITE'
  mseDIRECTORY='WHITE'

  mseACOLORS=(
    "BLACK" "DGREY" "WHITE" "SILVER" "RED" "LRED"
    "GREEN" "LGREEN" "BROWN" "YELLOW" "BLUE" "LBLUE"
    "PURPLE" "LPURPLE" "CYAN" "LCYAN"
  )

  if [ $# -ge 1 ]; then
    mseUColor=$(toUpperCase $1)

    for mseColor in "${mseACOLORS[@]}"; do
      if [ $mseUColor == $mseColor ]; then
        mseSYMBOLS=$mseColor
      fi
    done
  fi

  if [ $# -ge 2 ]; then
    mseUColor=$(toUpperCase $2)

    for mseColor in "${mseACOLORS[@]}"; do
      if [ $mseUColor == $mseColor ]; then
        mseUSERNAME=$mseColor
      fi
    done
  fi

  if [ $# -ge 3 ]; then
    mseUColor=$(toUpperCase $3)

    for mseColor in "${mseACOLORS[@]}"; do
      if [ $mseUColor == $mseColor ]; then
        mseDIRECTORY=$mseColor
      fi
    done
  fi


  PROMPT_COLOR_SYMBOLS=$mseSYMBOLS
  PROMPT_COLOR_USERNAME=$mseUSERNAME
  PROMPT_COLOR_DIRECTORY=$mseDIRECTORY

  unset mseSYMBOLS
  unset mseUSERNAME
  unset mseDIRECTORY
  unset mseACOLORS
}

#
# Mostra as configurações atualmente selecionadas para a
# amostragem do prompt.
#
showPromptSelection() {
  printf "\n\n${SILVER}As seguintes configurações estão definidas para o prompt${NONE}\n\n"
  printf "          ${LBLUE}STYLE${NONE}: ${PROMPT_STYLE}\n"
  printf "        ${LBLUE}SYMBOLS${NONE}: ${PROMPT_COLOR_SYMBOLS}\n"
  printf "       ${LBLUE}USERNAME${NONE}: ${PROMPT_COLOR_USERNAME}\n"
  printf "      ${LBLUE}DIRECTORY${NONE}: ${PROMPT_COLOR_DIRECTORY}\n\n"
}





#
# Efetua o processamento da seleção feitas para a configuração do prompt
# e retorna o seu string devidamente configurado.
#
#   @exemple
#     PS1=$(retrievePromptSelectionCode)
#
retrievePromptSelectionCode() {
  msePSQUEMA=${PROMPT_AVAILABLE_SQUEMA[$PROMPT_STYLEI]}
  msePSQUEMA="$(echo $msePSQUEMA | sed -e 's/\\\[\\e\[40;/\\e\[/g' | sed -e 's/\]\]\\\]/\]\]/g')"



  mseNEW="${RNONE}"
  mseREG='s/\[\[NONE\]\]/'"$mseNEW"'/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"



  TMP="R${PROMPT_COLOR_SYMBOLS}"
  mseNEW="${!TMP}"
  mseREG='s/\[\[SYMBOL\]\]/'"$mseNEW"'/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  TMP="R${PROMPT_COLOR_USERNAME}"
  mseNEW="${!TMP}"
  mseREG='s/\[\[USERNAME\]\]/'"$mseNEW"'/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  TMP="R${PROMPT_COLOR_DIRECTORY}"
  mseNEW="${!TMP}"
  mseREG='s/\[\[DIRECTORY\]\]/'"$mseNEW"'/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"


  mseREG='s/\\\$/\$/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  mseREG='s/\\u/'"$USER"'/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  mseHOSTNAME=`uname -n`
  mseREG='s/\\h/'"$mseHOSTNAME"'/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  mseDIRECTORY="\/etc\/skel\/myShellEnv"
  mseREG='s/\\w/'"$mseDIRECTORY"'/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  echo $msePSQUEMA


  unset msePSQUEMA
  unset mseNEW
  unset mseREG
  unset mseHOSTNAME
  unset mseDIRECTORY
}

#
# Baseado nas seleções feitas e que estão armazenadas nas variáveis
# de controle, monta o prompt conforme ele deve aparecer e mostra para o usuário.
#
previewPromptSelection() {
  msePSQUEMA=$(retrievePromptSelectionCode)

  printf "\n\n${SILVER}Resultado da configuração do prompt: ${NONE}"
  printf "\n${SILVER}...${NONE} \n"
  printf "${msePSQUEMA}"
  printf "\n${SILVER}...${NONE} \n\n"
}

#
# Efetivamente altera a configuração do prompt baseado nas configurações
# encontradas nas variáveis que armazenam as seleções feitas.
#
setPromptSelection() {
  PS1=$(retrievePromptSelectionCode)
}
