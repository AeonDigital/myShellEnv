#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
MSE_GB_PROMPT_OPTIONS="sim(s) | nao(n)"
MSE_GB_PROMPT_MSG=()
MSE_GB_PROMPT_INDENT="    "
MSE_GB_PROMPT_RESULT=""



#
# Mostra uma mensagem para o usuário e questiona sobre Sim ou Não
# A mensagem mostrada deve ser preparada no array ${MSE_GB_PROMPT_MSG}
# onde, cada item do array será definido em uma linha do terminal.
#
# O resultado selecionado pelo usuário ficará definido na variável ${MSE_GB_PROMPT_RESULT}
# armazenando os valores:
#   0 : nao(n)
#   1 : sim(s)
#
#   @example
#     MSE_GB_PROMPT_MSG=()
#     MSE_GB_PROMPT_MSG[0]=$(printf "${SILVER}ATENÇÃO!${NONE}")
#     MSE_GB_PROMPT_MSG[1]=$(printf "Deseja prosseguir?")
#
#     promptUser
#     if [ "$MSE_GB_PROMPT_RESULT" == "1" ]; then
#       printf "Escolhido Sim"
#     else
#       printf "Escolhido Não"
#     fi
#
promptUser() {
  MSE_GB_PROMPT_RESULT=""

  if [ ${#MSE_GB_PROMPT_MSG[@]} == 0 ] && [ ${#MSE_GB_INTERFACE_MSG[@]} == 0 ]; then
    errorAlert "${FUNCNAME[0]}" "empty array ${LGREEN}MSE_GB_PROMPT_MSG${NONE}"
  else
    if [ ${#MSE_GB_PROMPT_MSG[@]} == 0 ]; then
      MSE_GB_PROMPT_MSG=("${MSE_GB_INTERFACE_MSG[@]}")
    fi

    while [ "$MSE_GB_PROMPT_RESULT" != "sim" ] && [ "$MSE_GB_PROMPT_RESULT" != "s" ] && [ "$MSE_GB_PROMPT_RESULT" != "nao" ] && [ "$MSE_GB_PROMPT_RESULT" != "n" ]; do
      if [ "$MSE_GB_PROMPT_RESULT" != "" ]; then
        printf "${MSE_GB_PROMPT_INDENT}Esperado apenas [ ${MSE_GB_PROMPT_OPTIONS} ]: \"$MSE_GB_PROMPT_RESULT\" \n"
      fi

      for mseMsg in "${MSE_GB_PROMPT_MSG[@]}"; do
        printf "${MSE_GB_PROMPT_INDENT}$mseMsg \n"
      done

      unset mseMsg

      read -p "${MSE_GB_PROMPT_INDENT}[ ${MSE_GB_PROMPT_OPTIONS} ] : " MSE_GB_PROMPT_RESULT
      MSE_GB_PROMPT_RESULT=$(echo "$MSE_GB_PROMPT_RESULT" | awk '{print tolower($0)}')
    done


    if [ "$MSE_GB_PROMPT_RESULT" == "nao" ] || [ "$MSE_GB_PROMPT_RESULT" == "n" ]; then
      MSE_GB_PROMPT_RESULT=0
    fi

    if [ "$MSE_GB_PROMPT_RESULT" == "sim" ] || [ "$MSE_GB_PROMPT_RESULT" == "s" ]; then
      MSE_GB_PROMPT_RESULT=1
    fi

    MSE_GB_PROMPT_MSG=()
    MSE_GB_INTERFACE_MSG=()
  fi
}
