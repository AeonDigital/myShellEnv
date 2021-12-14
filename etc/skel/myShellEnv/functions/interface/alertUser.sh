#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Variáveis
MSE_GB_ALERT_MSG=()
MSE_GB_ALERT_INDENT="    "



#
# Mostra uma mensagem de alerta para o usuário.
#
# A mensagem mostrada deve ser preparada no array ${MSE_GB_ALERT_MSG}
# onde, cada item do array será definido em uma linha do terminal
#
#   @example
#     MSE_GB_ALERT_MSG=()
#     MSE_GB_ALERT_MSG[0]=$(printf "${WHITE}Sucesso!${NONE}")
#     MSE_GB_ALERT_MSG[1]=$(printf "Todos os scripts foram atualizados")
#
#     alertUser
#
alertUser() {
  if [ ${#MSE_GB_ALERT_MSG[@]} == 0 ] && [ ${#MSE_GB_INTERFACE_MSG[@]} == 0 ]; then
    errorAlert "${FUNCNAME[0]}" "empty array ${LGREEN}MSE_GB_ALERT_MSG${NONE}"
  else
    if [ ${#MSE_GB_ALERT_MSG[@]} == 0 ]; then
      MSE_GB_ALERT_MSG=("${MSE_GB_INTERFACE_MSG[@]}")
    fi

    local mseMsg
    for mseMsg in "${MSE_GB_ALERT_MSG[@]}"; do
      printf "${MSE_GB_ALERT_INDENT}${mseMsg}\n"
    done

    MSE_GB_ALERT_MSG=()
    MSE_GB_INTERFACE_MSG=()
  fi
}





#
# Teste
test_alertUser() {
  MSE_GB_ALERT_MSG[0]="Testando alert"

  ((mseCountAssert=mseCountAssert+1))
  local testResult=$(alertUser)
  local testExpected=$(echo -e "${MSE_GB_ALERT_INDENT}Testando alert")

  if [ "$testResult" == "$testExpected" ]; then
    testISOK=1
    echo "   OK"
  else
    testISOK=0
    echo "   FAIL"
    echo "   Result  : ${testResult}"
    echo "   Expected: ${testExpected}"
  fi
}
