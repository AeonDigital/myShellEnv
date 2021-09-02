#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
#
PROMPT_STYLE=SIMPLE
PROMPT_STYLEI=0
PROMPT_COLOR_SYMBOLS=WHITE
PROMPT_COLOR_USERNAME=DGREY
PROMPT_COLOR_DIRECTORY=DGREY
PROMPT_OPTIONS_CONFIG=(
  $PROMPT_STYLE $PROMPT_STYLEI
  $PROMPT_COLOR_SYMBOLS $PROMPT_COLOR_USERNAME $PROMPT_COLOR_DIRECTORY
)
PROMPT_PLACEHOLDERS=(
  "SYMBOLS" "USERNAME" "DIRECTORY"
)

PROMPT_AVAILABLE_STYLE_NAME=()
PROMPT_AVAILABLE_STYLE_FORMAT=()
PROMPT_AVAILABLE_SQUEMA=()


#
# Estilo simples
# > $ rianna@archlinux : _
PROMPT_AVAILABLE_STYLE_NAME[0]="SIMPLE"
PROMPT_AVAILABLE_STYLE_FORMAT[0]="${NONE}$ username@host : _"
PROMPT_AVAILABLE_SQUEMA[0]='[[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] :[[NONE]]\040'

#
# Estilo 'Nova linha 01'
# $ rianna@archlinux in ~/DirName/SubDir
# > _
PROMPT_AVAILABLE_STYLE_NAME[1]="NEWLINE01"
PROMPT_AVAILABLE_STYLE_FORMAT[1]="${NONE}\$ username@host in ~/atual/directory/path \n> _"
PROMPT_AVAILABLE_SQUEMA[1]='[[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n\076[[NONE]]\040'

#
# Estilo 'Nova linha 02'
# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─> _
PROMPT_AVAILABLE_STYLE_NAME[2]="NEWLINE02"
PROMPT_AVAILABLE_STYLE_FORMAT[2]="${NONE}\342\224\214\342\224\200\342\224\200 \$ username@host in ~/atual/directory/path \n\342\224\224\342\224\200\076 _"
PROMPT_AVAILABLE_SQUEMA[2]='[[DIRECTORY]]\[\342\224\]\214\[\342\224\]\200\[\342\224\]\200 [[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n[[DIRECTORY]]\[\342\224\]\224\[\342\224\]\200\076[[NONE]]\040'

#
# Estilo 'Nova linha 03'
# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─╼ _
PROMPT_AVAILABLE_STYLE_NAME[3]="NEWLINE03"
PROMPT_AVAILABLE_STYLE_FORMAT[3]="${NONE}\342\224\214\342\224\200\342\224\200 \$ username@host in ~/atual/directory/path \n\342\224\224\342\224\200\342\225\274 _"
PROMPT_AVAILABLE_SQUEMA[3]='[[DIRECTORY]]\[\342\224\]\214\[\342\224\]\200\[\342\224\]\200 [[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n[[DIRECTORY]]\[\342\224\]\224\[\342\225\]\274[[NONE]]\040'





#
# Mostra as configurações atualmente selecionadas para a
# amostragem do prompt.
#
showPromptConfig() {
  printf "\n${SILVER}As seguintes configurações estão definidas para o prompt${NONE}\n\n"
  printf "${LBLUE}STYLE${NONE}: ${PROMPT_STYLE}\n\n"


  local i
  local mseLength=${#PROMPT_PLACEHOLDERS[@]}
  local mseLine
  local mseRawTable
  local msePHName
  local msePHValue

  for (( i=0; i<mseLength; i++)); do
    msePHName='PROMPT_COLOR_'${PROMPT_PLACEHOLDERS[$i]}
    msePHValue="${!msePHName}"

    mseLine=" ${LBLUE}${PROMPT_PLACEHOLDERS[$i]}${NONE}:${msePHValue} \n"
    mseRawTable+="${mseLine}"
  done

  mseRawTable=$(printf "${mseRawTable}")
  column -e -t -s ":" -o " | " -N "PlaceHolder,Cor" <<< "${mseRawTable}"
  printf "\n"
}



#
# Salva as configurações atualmente definidas como o padrão para o prompt deste usuário.
#
savePromptConfig() {
  local mseCfgFile="$HOME"'/myShellEnv/functions/terminal/promptConfig.sh'

  setKeyValueConfiguration PROMPT_STYLE $PROMPT_STYLE $mseCfgFile
  setKeyValueConfiguration PROMPT_STYLEI $PROMPT_STYLEI $mseCfgFile

  setKeyValueConfiguration PROMPT_COLOR_SYMBOLS $PROMPT_COLOR_SYMBOLS $mseCfgFile
  setKeyValueConfiguration PROMPT_COLOR_USERNAME $PROMPT_COLOR_USERNAME $mseCfgFile
  setKeyValueConfiguration PROMPT_COLOR_DIRECTORY $PROMPT_COLOR_DIRECTORY $mseCfgFile

  PROMPT_OPTIONS_CONFIG=(
    $PROMPT_STYLE $PROMPT_STYLEI
    $PROMPT_COLOR_SYMBOLS $PROMPT_COLOR_USERNAME $PROMPT_COLOR_DIRECTORY
  )
}



#
# Restaura as configurações do último prompt salvo.
#
restorePromptConfig() {
  PROMPT_STYLE=${PROMPT_OPTIONS_CONFIG[0]}
  PROMPT_STYLEI=${PROMPT_OPTIONS_CONFIG[1]}

  PROMPT_COLOR_SYMBOLS=${PROMPT_OPTIONS_CONFIG[2]}
  PROMPT_COLOR_USERNAME=${PROMPT_OPTIONS_CONFIG[3]}
  PROMPT_COLOR_DIRECTORY=${PROMPT_OPTIONS_CONFIG[4]}

  PS1=$(retrievePromptSelectionCode 1)
}






#
# Mostra os prompts que estão aptos a serem usados pelo usuário.
#
#   @param mixed $1
#   Se omitido apresentará todas as opções de prompt.
#   Se "list", apresentará apenas a lista contendo o indice e respectivo nome.
#   Se "index" (0, 1, 2...) apresentará apenas o respectivo prompt de índice indicado.
#
showPromptStyles() {
  local i
  local mseLength=${#PROMPT_AVAILABLE_STYLE_NAME[@]}
  local mseType="complete"

  if [ $# == 1 ]; then
    if [ $1 == "" ]; then
      mseType="complete"
    else
      if [ $1 == "list" ]; then
        mseType="list"
      else
        mseType="index"
      fi
    fi
  fi


  if [ $mseType == "complete" ] || [ $mseType == "list" ]; then
    printf "\n${SILVER}Os seguintes estilos de prompts podem ser usados:${NONE}\n\n"

    printf "${SILVER}...${NONE}"
    for (( i=0; i<mseLength; i++)); do
      if [ $mseType == "complete" ]; then
        printf "\n${LBLUE}  ${PROMPT_AVAILABLE_STYLE_NAME[$i]}: ${NONE} \n"
        printf "${PROMPT_AVAILABLE_STYLE_FORMAT[$i]} \n"
      else
        printf "\n [$i] ${LBLUE} ${PROMPT_AVAILABLE_STYLE_NAME[$i]} ${NONE} "
      fi
    done
    printf "\n${SILVER}...${NONE} \n\n"

  else
    local mseREG='^[0-9]+$'
    if ! [[ $1 =~ $mseREG ]]; then
      errorAlert "${FUNCNAME[0]}" "argument 1 is not a integer"
    else
      if [ $1 -lt 0 ] || [ $1 -ge $mseLength ]; then
        errorAlert "${FUNCNAME[0]}" "argument 1 is out of range"
      else
        printf "\n"
        printf "${SILVER}... ${PROMPT_AVAILABLE_STYLE_NAME[$1]} ${NONE}\n\n"
        printf "${PROMPT_AVAILABLE_STYLE_FORMAT[$1]} \n\n"
        printf "${SILVER}...${NONE} \n\n"
      fi
    fi
  fi
}

#
# Define o tipo do prompt que será usado.
# Não efetua alterações até que o comando 'redefinePrompt' seja executado.
#
#   @param string|int $1
#   Estilo do prompt a ser usado (pelo nome ou pelo indice).
#
#   @example
#     selectPromptStyle SIMPLE
#
selectPromptStyle() {
  if [ $# != 1 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 arguments"
  else
    local mseIsValid=0
    local mseCounter=0
    local mseUStyle=$(toUpperCase $1)
    local mseStyle

    for mseStyle in "${PROMPT_AVAILABLE_STYLE_NAME[@]}"; do
      if [ $mseUStyle == $mseStyle ] || [ $mseUStyle == $mseCounter ]; then
        mseIsValid=1
        PROMPT_STYLE=$mseStyle
        PROMPT_STYLEI=$mseCounter
      fi
      mseCounter="$((mseCounter + 1))"
    done

    if [ $mseIsValid == 0 ]; then
      errorAlert "${FUNCNAME[0]}" "invalid argument" "see options in ${LGREEN}showPromptStyles${NONE}"
    else
      PS1=$(retrievePromptSelectionCode 1)
    fi
  fi
}





#
# Mostra os códigos de cores disponíveis para estilização do prompt.
# Tratam-se das mesmas cores usadas para a estilização de textos.
#
showPromptColors() {
  showTextColors 3
}

#
# Mostra para o usuário todas as opções de 'placeholder' que podem
# ser estilizadas no seu prompt.
#
showPromptPlaceHolders() {
  local i
  local mseLength=${#PROMPT_PLACEHOLDERS[@]}

  printf "\n${SILVER}Os seguintes placeholders podem ter suas cores definidas:${NONE}\n"
  printf "${DGREY}[ A efetividade de item varia conforme a aplicação do mesmo no estilo de prompt escolhido ]${NONE}\n\n"

  printf "${SILVER}...${NONE}\n"
  for (( i=0; i<mseLength; i++)); do
    printf " [$i] ${LBLUE} ${PROMPT_PLACEHOLDERS[$i]} ${NONE} \n"
  done
  printf "${SILVER}...${NONE}\n\n"
}

#
# Define a cor para um 'placeholder' do prompt.
#
#   $param string $1
#   Nome do placeholder a ser definido.
#
#   @param string $2
#   Nome do código da cor a ser usado para este placeholder
#
#   @example
#     selectPromptPlaceHolderColor "SYMBOLS" "DGREY"
#
selectPromptPlaceHolderColor() {
  if [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 2 arguments"
  else
    local msePlaceHolder
    local mseUPlaceHolder=$(toUpperCase $1)
    local mseColorRaw
    local mseUColorRaw=$(toUpperCase $2)
    local mseIsValid=0

    for msePlaceHolder in "${PROMPT_PLACEHOLDERS[@]}"; do
      if [ $mseUPlaceHolder == $msePlaceHolder ]; then
        mseIsValid=1
      fi
    done

    if [ $mseIsValid == 0 ]; then
      errorAlert "${FUNCNAME[0]}" "invalid argument 1" "see options in ${LGREEN}showPromptPlaceHolders${NONE}"
    else
      mseIsValid=0

      for mseColorRaw in "${MSE_GB_AVAILABLE_COLORS_RAW[@]}"; do
        if [ $mseUColorRaw == $mseColorRaw ]; then
          mseIsValid=1
        fi
      done

      if [ $mseIsValid == 0 ]; then
        errorAlert "${FUNCNAME[0]}" "invalid argument 2" "see options in ${LGREEN}showPromptColors${NONE}"
      else
        local msePHArray='PROMPT_COLOR_'$mseUPlaceHolder
        eval "$msePHArray"="$mseUColorRaw"

        PS1=$(retrievePromptSelectionCode 1)
      fi
    fi
  fi
}










#
# Efetua o processamento da seleção feitas para a configuração do prompt
# e retorna o seu string devidamente configurado.
#
#   @param bool $1
#   Use '1' quando desejar que o resultado obtido vá ser usado para efetivamente
#   definir as variáveis de ambiente que estilizam o prompt.
#   Use '0' se quiser apenas obter o resultado para visualizar.
#
#   @exemple
#     PS1=$(retrievePromptSelectionCode 0)
#
retrievePromptSelectionCode() {
  local msePSQUEMA
  local mseNEW
  local mseREG
  local mseTMP
  local mseHOSTNAME=`uname -n`
  local mseDIRECTORY="\/etc\/skel\/myShellEnv"

  msePSQUEMA=${PROMPT_AVAILABLE_SQUEMA[$PROMPT_STYLEI]}
  msePSQUEMA="$(echo $msePSQUEMA | sed -e 's/\\\[\\e\[40;/\\e\[/g' | sed -e 's/\]\]\\\]/\]\]/g')"


  msePOS='NONE'
  mseCOD="${!msePOS}"
  mseREG='s/\[\['$msePOS'\]\]/\\[\\'$mseCOD'\\]/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  msePOS='SYMBOLS'
  mseNAM='PROMPT_COLOR_'${msePOS}
  mseCOD="${!mseNAM}"
  mseCOD="${!mseCOD}"
  mseREG='s/\[\['$msePOS'\]\]/\\[\\'$mseCOD'\\]/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  msePOS='USERNAME'
  mseNAM='PROMPT_COLOR_'${msePOS}
  mseCOD="${!mseNAM}"
  mseCOD="${!mseCOD}"
  mseREG='s/\[\['$msePOS'\]\]/\\[\\'$mseCOD'\\]/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

  msePOS='DIRECTORY'
  mseNAM='PROMPT_COLOR_'${msePOS}
  mseCOD="${!mseNAM}"
  mseCOD="${!mseCOD}"
  mseREG='s/\[\['$msePOS'\]\]/\\[\\'$mseCOD'\\]/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"



  if [ $# == 0 ] || [ $1 != 1 ]; then
    mseREG='s/\\\$/\$/g'
    msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

    mseREG='s/\\u/'"$USER"'/g'
    msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

    mseREG='s/\\h/'"$mseHOSTNAME"'/g'
    msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"

    mseREG='s/\\w/'"$mseDIRECTORY"'/g'
    msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"
  fi

  echo $msePSQUEMA
}
