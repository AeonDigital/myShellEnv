#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
ALERT_WAIT_PROMPT="Precione qualquer tecla para prosseguir."



#
# Mostra uma mensagem de alerta para o usuário e aguarda ele digitar qualquer tecla.
#
# A mensagem mostrada deve ser preparada no array ${ALERT_MSG}
# onde, cada item do array será definido em uma linha do terminal
#
#   @example
#     ALERT_MSG=()
#     ALERT_MSG[0]=$(printf "${SILVER}Sucesso!${NONE}")
#     ALERT_MSG[1]=$(printf "Todos os scripts foram atualizados")
#
#     waitUser
#
waitUser() {
  if [ ${#ALERT_MSG[@]} == 0 ] && [ ${#INTERFACE_MSG[@]} == 0 ]; then
    errorAlert "${FUNCNAME[0]}" "empty array ${LGREEN}ALERT_MSG${NONE}"
  else
    if [ ${#ALERT_MSG[@]} == 0 ]; then
      ALERT_MSG=("${INTERFACE_MSG[@]}")
    fi

    for msg in "${ALERT_MSG[@]}"; do
      printf "${ALERT_INDENT}$msg \n"
    done
    read -n 1 -s -r -p "${ALERT_INDENT}[ ${ALERT_WAIT_PROMPT} ] `echo $'\n'`"

    ALERT_MSG=()
    INTERFACE_MSG=()
  fi
}
