#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
PROMPT_OPTIONS="sim(s) | nao(n)"
PROMPT_MSG=()
PROMPT_INDENT="    "
PROMPT_RESULT=""



#
# Mostra uma mensagem para o usuário e questiona sobre Sim ou Não
# A mensagem mostrada deve ser preparada no array ${PROMPT_MSG}
# onde, cada item do array será definido em uma linha do terminal.
#
# O resultado selecionado pelo usuário ficará definido na variável ${PROMPT_RESULT}
# armazenando os valores:
#   0 : nao(n)
#   1 : sim(s)
#
#   @example
#     PROMPT_MSG=()
#     PROMPT_MSG[0]=$(printf "${SILVER}ATENÇÃO!${NONE}")
#     PROMPT_MSG[1]=$(printf "Deseja prosseguir?")
#
#     promptUser
#     if [ "$PROMPT_RESULT" == "1" ]; then
#       printf "Escolhido Sim"
#     else
#       printf "Escolhido Não"
#     fi
#
promptUser() {
  PROMPT_RESULT=""

  if [ ${#PROMPT_MSG[@]} == 0 ] && [ ${#INTERFACE_MSG[@]} == 0 ]; then
    errorAlert "${FUNCNAME[0]}" "empty array ${LGREEN}PROMPT_MSG${NONE}"
  else
    if [ ${#PROMPT_MSG[@]} == 0 ]; then
      PROMPT_MSG=("${INTERFACE_MSG[@]}")
    fi

    while [ "$PROMPT_RESULT" != "sim" ] && [ "$PROMPT_RESULT" != "s" ] && [ "$PROMPT_RESULT" != "nao" ] && [ "$PROMPT_RESULT" != "n" ]; do
      if [ "$PROMPT_RESULT" != "" ]; then
        printf "${PROMPT_INDENT}Esperado apenas [ ${PROMPT_OPTIONS} ]: \"$PROMPT_RESULT\" \n"
      fi

      for msg in "${PROMPT_MSG[@]}"; do
        printf "${PROMPT_INDENT}$msg \n"
      done

      read -p "${PROMPT_INDENT}[ ${PROMPT_OPTIONS} ] : " PROMPT_RESULT
      PROMPT_RESULT=$(echo "$PROMPT_RESULT" | awk '{print tolower($0)}')
    done


    if [ "$PROMPT_RESULT" == "nao" ] || [ "$PROMPT_RESULT" == "n" ]; then
      PROMPT_RESULT=0
    fi

    if [ "$PROMPT_RESULT" == "sim" ] || [ "$PROMPT_RESULT" == "s" ]; then
      PROMPT_RESULT=1
    fi

    PROMPT_MSG=()
    INTERFACE_MSG=()
  fi
}
