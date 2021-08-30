#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Repositório dos scripts de instalação e atualização
URL_ETC="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/"
URL_MYSHELLENV="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/etc/skel/myShellEnv/"
URL_UPDATE="https://raw.githubusercontent.com/AeonDigital/Tutorial-Arch/master/shell/"





#
# Atualiza os arquivos que compõe o 'myShellEnv'.
#
updateMyShellEnv() {
  curl -O "${URL_UPDATE}updateMyShellEnv.sh"
  chmod u+x updateMyShellEnv.sh
  ./updateMyShellEnv.sh
}
#
# Efetua a reinstalação completa do 'myShellEnv'.
#
reinstallMyShellEnv() {
  curl -O "${URL_UPDATE}installMyShellEnv.sh"
  chmod u+x installMyShellEnv.sh
  ./installMyShellEnv.sh
}





FUNCTION_NAMES=()
FUNCTION_DESCRIPTIONS=()

#
# Efetua o registro de funções de usuário aos arrays de controle.
#
# param $1 nome da função
# param $2 descrição da função
#
# return void
registerUserFunction() {
  if [ "$#" != "2" ]; then
    echo "Error in ${FUNCNAME[0]}: expected 2 arguments"
  else
    length=${#FUNCTION_NAMES[@]}
    FUNCTION_NAMES[length]=$1
    FUNCTION_DESCRIPTIONS[length]=$2
  fi
}
#
# Lista todas as funções de usuário registradas no momento
#
# return void
listUserFunctions() {
  length=${#FUNCTION_NAMES[@]}

  for ((i=0;i<length;i++)); do
    fName=${FUNCTION_NAMES[i]}
    fDesc=${FUNCTION_DESCRIPTIONS[i]}
    num=i+1

    if num < 10 ; then
      num="0${num}"
    fi

    echo -e "${num} :: ${fName}"
    echo -e "    ${fDesc}"
  done
}
