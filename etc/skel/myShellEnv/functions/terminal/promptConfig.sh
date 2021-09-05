#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
#
# As variáveis abaixo guardam a configuração atual do prompt.
# Há 2 conjuntos de variáveis que são usadas para tal tarefa.
#
#   - STYLE
#   Armazenam informações referentes ao estilo do prompt que é a forma
#   física como ele é apresentado.
#
#   - PLACEHOLDERS
#   Estes são 'espaços reservados' dentro do estilo selecionado que permite
#   que a informação abrigada no mesmo tenha sua coloração configurada.
#


#
# Definição dos estilos dos prompts
#
MSE_PROMPT_STYLE_NAME=()
MSE_PROMPT_STYLE_SAMPLE=()
MSE_PROMPT_STYLE_SQUEMA=()


#
# Registra todos os placeholders disponíveis para configuração de todos os
# tipos de estilos definidos.
#
# A marcação especial [[NONE]] pode ser usada para encerrar totalmente a estilização
# de uma cadeia de caracteres. Ela faz com que a marcação de texto volte ao padrão
# definido que é com a cor de fonte Cinza claro e fundo preto.
#
MSE_PROMPT_STYLE_PLACEHOLDERS=(
  "SYMBOLS" "USERNAME" "DIRECTORY"
)





#
# Estilo simples
# > $ rianna@archlinux : _
MSE_PROMPT_STYLE_NAME[0]="SIMPLE"
MSE_PROMPT_STYLE_SAMPLE[0]="${NONE}$ username@host : _"
MSE_PROMPT_STYLE_SQUEMA[0]='[[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] :[[NONE]]\040'

#
# Estilo 'Nova linha 01'
# $ rianna@archlinux in ~/DirName/SubDir
# > _
MSE_PROMPT_STYLE_NAME[1]="NEWLINE01"
MSE_PROMPT_STYLE_SAMPLE[1]="${NONE}\$ username@host in ~/atual/directory/path \n> _"
MSE_PROMPT_STYLE_SQUEMA[1]='[[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n\076[[NONE]]\040'

#
# Estilo 'Nova linha 02'
# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─> _
MSE_PROMPT_STYLE_NAME[2]="NEWLINE02"
MSE_PROMPT_STYLE_SAMPLE[2]="${NONE}\342\224\214\342\224\200\342\224\200 \$ username@host in ~/atual/directory/path \n\342\224\224\342\224\200\076 _"
MSE_PROMPT_STYLE_SQUEMA[2]='[[DIRECTORY]]\[\342\224\]\214\[\342\224\]\200\[\342\224\]\200 [[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n[[DIRECTORY]]\[\342\224\]\224\[\342\224\]\200\076[[NONE]]\040'

#
# Estilo 'Nova linha 03'
# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─╼ _
MSE_PROMPT_STYLE_NAME[3]="NEWLINE03"
MSE_PROMPT_STYLE_SAMPLE[3]="${NONE}\342\224\214\342\224\200\342\224\200 \$ username@host in ~/atual/directory/path \n\342\224\224\342\224\200\342\225\274 _"
MSE_PROMPT_STYLE_SQUEMA[3]='[[DIRECTORY]]\[\342\224\]\214\[\342\224\]\200\[\342\224\]\200 [[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n[[DIRECTORY]]\[\342\224\]\224\[\342\225\]\274[[NONE]]\040'





#
# Armazena o nome do estilo que está sendo usado neste momento.
MSE_PROMPT_SELECTED_STYLE=SIMPLE
MSE_PROMPT_SELECTED_STYLE_INDEX=0


#
# Armazena a coleção de cores definidas para cada um dos possíveis placeholders
#
# Para cada placeholder, a configuração de cores deve ser armazenada numa única string
# onde cada item é separada por um espaço e respeitando a seguinte ordem:
#
#   @example
#     [PLACEHOLDER]="FONTE FUNDO ATRIBUTO"
#     [SYMBOLS]="LGREY BLACK DEFAULT"
#
declare -A MSE_PROMPT_SELECTED_COLORS=(
  [SYMBOLS]="LGREY BLACK DEFAULT"
  [USERNAME]="DGREY BLACK DEFAULT"
  [DIRECTORY]="DGREY BLACK DEFAULT"
)


#
# Armazena a configuração definida inicialmente para o prompt permitindo
# que a mesma seja recuperada após alterações.
# Quando o usuário salvar uma nova configuração não será mais possível recuperar pois
# estes valores serão sobrescritos
declare -A MSE_PROMPT_LAST_SAVE_CONFIG=(
  [STYLE]=$MSE_PROMPT_SELECTED_STYLE
  [STYLE_INDEX]=$MSE_PROMPT_SELECTED_STYLE_INDEX
)


#
# Preenche automaticamente o array ${MSE_PROMPT_LAST_SAVE_CONFIG}
for key in "${!MSE_PROMPT_SELECTED_COLORS[@]}"; do
  MSE_PROMPT_LAST_SAVE_CONFIG[${key}]=${MSE_PROMPT_SELECTED_COLORS[${key}]}
done
unset key










#
# Mostra as configurações atualmente selecionadas para a
# amostragem do prompt.
#
showPromptConfig() {
  printf "\n${WHITE}As seguintes configurações estão definidas para o prompt${NONE}\n\n"
  printf "${LBLUE}STYLE${NONE}: ${MSE_PROMPT_SELECTED_STYLE}\n\n"

  local key
  local mseLine
  local mseRawTable


  local msePHRawConfig
  local msePHConfig

  local msePHFont
  local msePHBG
  local msePHAttr

  local msePHColor
  local msePHSample

  for key in "${!MSE_PROMPT_SELECTED_COLORS[@]}"; do
    msePHFont='Error'
    msePHBG='Error'
    msePHAttr='Error'

    msePHColor=''
    msePHSample='myShellEnv'


    #
    # resgata as configurações do respectivo placeholder
    msePHRawConfig="${MSE_PROMPT_SELECTED_COLORS[$key]}"

    #
    # separa cada uma das configurações em um array onde, em
    # cada posição estará uma delas.
    msePHConfig=(${msePHRawConfig// / })


    if [ ${#msePHConfig[@]} -ge 1 ]; then
      msePHFont="${msePHConfig[0]}"
    fi
    if [ ${#msePHConfig[@]} -ge 2 ]; then
      msePHBG="${msePHConfig[1]}"
    fi
    if [ ${#msePHConfig[@]} -ge 3 ]; then
      msePHAttr="${msePHConfig[2]}"

      msePHColor=$(createFontStyle " ${msePHFont}" "${msePHBG}" "${msePHAttr}")
      msePHSample="${msePHColor}myShellEnv${NONE}"
    fi


    mseLine="${key}:${msePHFont}:${msePHBG}:${msePHAttr}:${msePHSample}\n"
    mseRawTable+="${mseLine}"
  done

  mseRawTable=$(printf "${mseRawTable}")
  column -e -t -s ":" -o " | " -N "PlaceHolder,FontColor,BGColor,Attribute,Sample" <<< "${mseRawTable}"
  printf "\n"
}



#
# Salva as configurações atualmente definidas como o padrão para o prompt deste usuário.
# !!!!!!!!!!!!!!!!!!!!!!
#savePromptConfig() {
  #local mseCfgFile="$HOME"'/myShellEnv/functions/terminal/promptConfig.sh'

  #setKeyValueConfiguration MSE_PROMPT_SELECTED_STYLE $MSE_PROMPT_SELECTED_STYLE $mseCfgFile
  #setKeyValueConfiguration MSE_PROMPT_SELECTED_STYLE_INDEX $MSE_PROMPT_SELECTED_STYLE_INDEX $mseCfgFile

  #setKeyValueConfiguration PROMPT_COLOR_SYMBOLS $PROMPT_COLOR_SYMBOLS $mseCfgFile
  #setKeyValueConfiguration PROMPT_COLOR_USERNAME $PROMPT_COLOR_USERNAME $mseCfgFile
  #setKeyValueConfiguration PROMPT_COLOR_DIRECTORY $PROMPT_COLOR_DIRECTORY $mseCfgFile

  #MSE_PROMPT_LAST_SAVE_CONFIG=(
  #  $MSE_PROMPT_SELECTED_STYLE $MSE_PROMPT_SELECTED_STYLE_INDEX
  #  $PROMPT_COLOR_SYMBOLS $PROMPT_COLOR_USERNAME $PROMPT_COLOR_DIRECTORY
  #)
#}



#
# Restaura as configurações do último prompt salvo.
#
restorePromptConfig() {

  local key
  MSE_PROMPT_SELECTED_COLORS=()

  for key in "${!MSE_PROMPT_LAST_SAVE_CONFIG[@]}"; do
    if [ $key == "STYLE" ]; then
      MSE_PROMPT_SELECTED_STYLE=${MSE_PROMPT_LAST_SAVE_CONFIG[${key}]}
    elif [ $key == "STYLE_INDEX" ]; then
      MSE_PROMPT_SELECTED_STYLE_INDEX=${MSE_PROMPT_LAST_SAVE_CONFIG[${key}]}
    else
      MSE_PROMPT_SELECTED_COLORS[${key}]=${MSE_PROMPT_LAST_SAVE_CONFIG[${key}]}
    fi
  done

  PS1=$(retrievePromptSelectionCode 1)
}





#
# Mostra os prompts que estão aptos a serem usados pelo usuário.
#
#   @param mixed $1
#   Se omitido apresentará todas as opções de prompt.
#   Se "list", apresentará apenas a lista contendo o índice e respectivo nome.
#   Se "index" (0, 1, 2...) apresentará apenas o respectivo prompt de índice indicado.
#
showPromptStyles() {
  local i
  local mseLength=${#MSE_PROMPT_STYLE_NAME[@]}
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
    printf "\n${WHITE}Os seguintes estilos de prompts podem ser usados:${NONE}\n\n"

    printf "${WHITE}...${NONE}"
    for (( i=0; i<mseLength; i++)); do
      if [ $mseType == "complete" ]; then
        printf "\n${LBLUE}  ${MSE_PROMPT_STYLE_NAME[$i]}: ${NONE} \n"
        printf "${MSE_PROMPT_STYLE_SAMPLE[$i]} \n"
      else
        printf "\n [$i] ${LBLUE} ${MSE_PROMPT_STYLE_NAME[$i]} ${NONE} "
      fi
    done
    printf "${WHITE}...${NONE} \n\n"

  else
    local mseREG='^[0-9]+$'
    if ! [[ $1 =~ $mseREG ]]; then
      errorAlert "${FUNCNAME[0]}" "argument 1 is not a integer"
    else
      if [ $1 -lt 0 ] || [ $1 -ge $mseLength ]; then
        errorAlert "${FUNCNAME[0]}" "argument 1 is out of range"
      else
        printf "\n"
        printf "${WHITE}... ${MSE_PROMPT_STYLE_NAME[$1]} ${NONE}\n\n"
        printf "${MSE_PROMPT_STYLE_SAMPLE[$1]} \n\n"
        printf "${WHITE}...${NONE} \n\n"
      fi
    fi
  fi
}


#
# Define o tipo do prompt que será usado.
# A alteração de estilo é feita imediatamente mas não será efetivada para as próximas
# sessões a não ser que seja usado o comando 'savePromptConfig'.
#
# Caso queira retornar para a configuração original da sessão use o comando 'restorePromptConfig'.
#
#   @param string|int $1
#   Estilo do prompt a ser usado (pelo nome ou pelo índice).
#
#   @example
#     redefinePromptStyleTo SIMPLE
#
redefinePromptStyleTo() {
  if [ $# != 1 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 arguments"
  else
    local mseLength
    local mseUParam
    local mseIsValid



    #
    # Resgata o estilo de prompt a ser usado
    mseLength=${#MSE_PROMPT_STYLE_NAME[@]}
    mseUParam=$(toUpperCase $1)
    mseIsValid=0

    for (( i=0; i<mseLength; i++)); do
      if [ $mseUParam == ${MSE_PROMPT_STYLE_NAME[$i]} ] || [ $mseUParam == $i ]; then
        MSE_PROMPT_SELECTED_STYLE=${MSE_PROMPT_STYLE_NAME[$i]}
        MSE_PROMPT_SELECTED_STYLE_INDEX=$i
        mseIsValid=1
      fi
    done


    if [ $mseIsValid == 0 ]; then
      errorAlert "${FUNCNAME[0]}" "invalid argument" "see options in ${LGREEN}showPromptStyles${NONE}"
    else
      PS1=$(retrievePromptSelectionCode 1)
    fi
  fi
}





#
# Mostra para o usuário todas as opções de 'placeholder' que podem
# ser estilizadas para os prompts atualmente registrados.
#
showPromptPlaceHolders() {
  local i
  local mseLength=${#MSE_PROMPT_STYLE_PLACEHOLDERS[@]}

  printf "\n${WHITE}Os seguintes placeholders podem ter suas cores definidas:${NONE}\n"
  printf "${DGREY} | A efetividade de cada configuração varia conforme a aplicação do respectivo | ${NONE}\n"
  printf "${DGREY} | placeholder no estilo de prompt escolhido                                   | ${NONE}\n"

  printf "${WHITE}...${NONE}\n"
  for (( i=0; i<mseLength; i++)); do
    printf " [$i] ${LBLUE} ${MSE_PROMPT_STYLE_PLACEHOLDERS[$i]} ${NONE} \n"
  done
  printf "${WHITE}...${NONE}\n\n"
}


#
# Define o estilo de cor para um 'placeholder' do prompt.
#
#   $param string $1
#   Nome do placeholder a ser definido.
#
#   @param string $2
#   Nome da cor para a fonte
#
#   @param string $3
#   Nome da cor para o background.
#   Se não for definida usará o padrão que é fundo preto.
#
#   @param string $4
#   Nome do atributo de fonte a ser usado
#   Se não for definida usará o padrão que é 'nenhum'.
#
#   @example
#     redefinePromptPlaceHolderStyleTo "SYMBOLS" "DGREY" "LBLUE"
#
redefinePromptPlaceHolderStyleTo() {
  if [ $# -lt 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 2, 3 or 4 arguments"
  else

    local msePlaceHolder
    local msePHFont
    local msePHBG='BLACK'
    local msePHAttr='DEFAULT'


    local mseLength
    local mseUParam
    local mseIsValid



    #
    # Identifica o placeholder que está sendo definido
    mseLength=${#MSE_PROMPT_STYLE_PLACEHOLDERS[@]}
    mseUParam=$(toUpperCase $1)
    mseIsValid=0

    for (( i=0; i<mseLength; i++)); do
      if [ $mseUParam == ${MSE_PROMPT_STYLE_PLACEHOLDERS[$i]} ]; then
        msePlaceHolder=$mseUParam
        mseIsValid=1
      fi
    done


    #
    # Apenas se o placeholder selecionado é válido...
    if [ $mseIsValid == 0 ]; then
      errorAlert "${FUNCNAME[0]}" "invalid argument 1" "see options in ${LGREEN}showPromptPlaceHolders${NONE}"
    else

      #
      # Identifica a cor de fonte a ser usada no placeholder
      mseLength=${#MSE_GB_AVAILABLE_COLOR_NAMES[@]}
      mseUParam=$(toUpperCase $2)
      mseIsValid=0

      for (( i=0; i<mseLength; i++)); do
        if [ $mseUParam == ${MSE_GB_AVAILABLE_COLOR_NAMES[$i]} ]; then
          msePHFont=$mseUParam
          mseIsValid=1
        fi
      done


      #
      # Apenas se a cor da fonte é válida...
      if [ $mseIsValid == 0 ]; then
        errorAlert "${FUNCNAME[0]}" "invalid argument 2" "see options in ${LGREEN}showFontColors${NONE}"
      else

        #
        # Caso o terceiro parametro tenha sido definido, verifica
        # se trata-se de uma cor de fundo válida
        if [ $# -ge 3 ]; then
          mseLength=${#MSE_GB_AVAILABLE_COLOR_NAMES[@]}
          mseUParam=$(toUpperCase $3)
          mseIsValid=0

          for (( i=0; i<mseLength; i++)); do
            if [ $mseUParam == ${MSE_GB_AVAILABLE_COLOR_NAMES[$i]} ]; then
              msePHBG=$mseUParam
              mseIsValid=1
            fi
          done
        fi


        #
        # Apenas se a cor de fundo é válida...
        if [ $mseIsValid == 0 ]; then
          errorAlert "${FUNCNAME[0]}" "invalid argument 3" "see options in ${LGREEN}showFontColors${NONE}"
        else

          #
          # Caso o quarto parametro tenha sido definido, verifica
          # se trata-se de um nome de atributo válido
          if [ $# -ge 4 ]; then
            mseLength=${#MSE_GB_AVAILABLE_FONT_ATTRIBUTE_NAMES[@]}
            mseUParam=$(toUpperCase $4)
            mseIsValid=0

            for (( i=0; i<mseLength; i++)); do
              if [ $mseUParam == ${MSE_GB_AVAILABLE_FONT_ATTRIBUTE_NAMES[$i]} ]; then
                msePHAttr=$mseUParam
                mseIsValid=1
              fi
            done
          fi


          #
          # Se o atributo definido não for válido...
          if [ $mseIsValid == 0 ]; then
            errorAlert "${FUNCNAME[0]}" "invalid argument 3" "see options in ${LGREEN}showFontAttributes${NONE}"
          fi

        fi
      fi
    fi



    #
    # Se a seleção das propriedades é válida
    if [ $mseIsValid == 1 ]; then
        MSE_PROMPT_SELECTED_COLORS[$msePlaceHolder]="${msePHFont} ${msePHBG} ${msePHAttr}"
        PS1=$(retrievePromptSelectionCode 1)
    fi
  fi
}










#
# Efetua o processamento das seleções armazenadas na variável ${MSE_PROMPT_SELECTED_COLORS} e retorna
# uma string de prompt defindamente configurado.
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

  local mseOLD
  local mseNEW
  local mseREG
  local msePSQUEMA


  local msePHName
  local mseIsOk=1

  local msePHRawConfig
  local msePHConfig
  local msePGStyle

  local mseHOSTNAME=`uname -n`
  local mseDIRECTORY="\/etc\/skel\/myShellEnv"



  #
  # primeiramente identifica o squema do estilo de prompt que será setado
  msePSQUEMA=${MSE_PROMPT_STYLE_SQUEMA[$MSE_PROMPT_SELECTED_STYLE_INDEX]}


  #
  # Adiciona todos os marcadores de 'término de estilos'
  # nas respectivas posições [[NONE]] encontradas no squema do estilo selecionado
  mseOLD='NONE'
  mseNEW="${!mseOLD}"
  mseREG='s/\[\['$mseOLD'\]\]/\\[\\'$mseNEW'\\]/g'
  msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"



  #
  # Para cada placeholder configurado
  # aplica o estilo nas posições correspondentes
  for msePHName in "${!MSE_PROMPT_SELECTED_COLORS[@]}"; do
    if [ $msePHName != "STYLE" ] && [ $msePHName != "STYLE_INDEX" ]; then
      msePHRawConfig=${MSE_PROMPT_SELECTED_COLORS[$msePHName]}
      msePHConfig=(${msePHRawConfig// / })

      if [ ${#msePHConfig[@]} != 3 ]; then
        errorAlert "${FUNCNAME[0]}" "invalid ${WHITE}${msePHName}${NONE} placeholder configuration" "Found: ${msePHRawConfig}"
        mseIsOk=0
      else
        msePGStyle=$(createFontStyle "${msePHConfig[0]}" "${msePHConfig[1]}" "${msePHConfig[2]}")

        mseREG='s/\[\['$msePHName'\]\]/\\[\\'$msePGStyle'\\]/g'
        msePSQUEMA="$(echo $msePSQUEMA | sed -e ${mseREG})"
      fi
    fi
  done



  #
  # Sendo para retornar o valor apenas para ser apresentado, sem
  # pretenção real de uso no prompt.
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
