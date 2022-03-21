#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
# No diretório raiz use o comando abaixo para carregar o módulo
# . src/init.sh
#
# No diretório raiz use o comando abaixo para executar os testes
# ./src/runTests.sh






#
# Configuração para o registro deste módulo
MSE_TMP_THIS_MODULE_NAME="myShellEnv"
MSE_TMP_THIS_MODULE_DIRECTORY=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MSE_TMP_ISOK=1
MSE_TMP_THIS_MODULE_DEPENDENCY=()



#
# Identifica se o módulo principal está carregado.
# Caso seja necessário, tenta carregá-lo
if [ "$(type -t "mse_mod_registerModule")" != "function" ]; then
  MSE_TMP_PATH_TO_MAIN_MODULE_INIT_SCRIPT="${MSE_TMP_THIS_MODULE_DIRECTORY}/../Shell-MSE-Main-Module/src/init.sh"

  if [ ! -f "${MSE_TMP_PATH_TO_MAIN_MODULE_INIT_SCRIPT}" ]; then
    MSE_TMP_ISOK=0
    printf "\n"
    printf "    Attention\n"
    printf "    The module \"Shell-MSE-Main-Module\" was not loaded.\n"
    printf "    Use the following commands to load it:\n"
    printf "    - git submodule update --remote \n"
    printf "\n"
  else
    #
    # Carrega o módulo principal.
    . "${MSE_TMP_PATH_TO_MAIN_MODULE_INIT_SCRIPT}"
  fi

  unset MSE_TMP_PATH_TO_MAIN_MODULE_INIT_SCRIPT
fi



if [ ${MSE_TMP_ISOK} == 1 ]; then
  #
  # Se o locale para as mensagens não está definido, usa o padrão 'en-us',
  if [ -z ${MSE_GLOBAL_MODULE_LOCALE+x} ]; then
    MSE_GLOBAL_MODULE_LOCALE="en-us"
  fi
  MSE_TMP_PATH_TO_LOCALE="${MSE_TMP_THIS_MODULE_DIRECTORY}/locale/${MSE_GLOBAL_MODULE_LOCALE}.sh"
  if [ ! -f "${MSE_TMP_PATH_TO_LOCALE}" ]; then
    MSE_TMP_PATH_TO_LOCALE="${MSE_TMP_THIS_MODULE_DIRECTORY}/locale/en-us.sh"
  fi
  . "${MSE_TMP_PATH_TO_LOCALE}"
  unset MSE_TMP_PATH_TO_LOCALE



  #
  # Carrega as variáveis do módulo caso um arquivo 'variables.sh' esteja definido
  if [ -f "${MSE_TMP_THIS_MODULE_DIRECTORY}/config/variables.sh" ]; then
    . "${MSE_TMP_THIS_MODULE_DIRECTORY}/config/variables.sh"
  fi

  #
  # Carrega os 'aliases' do módulo caso um arquivo 'aliases.sh' esteja definido
  if [ -f "${MSE_TMP_THIS_MODULE_DIRECTORY}/config/aliases.sh" ]; then
    . "${MSE_TMP_THIS_MODULE_DIRECTORY}/config/aliases.sh"
  fi

  #
  # Registra este próprio módulo
  mse_mod_registerModule "${MSE_TMP_THIS_MODULE_NAME}" "${MSE_TMP_THIS_MODULE_DIRECTORY}"

  #
  # Existindo dependências para o funcionamento deste módulo,
  # tenta carregá-las
  if [ ${#MSE_TMP_THIS_MODULE_DEPENDENCY[@]} -gt 0 ]; then
    for mseDependency in "${MSE_TMP_THIS_MODULE_DEPENDENCY[@]}";
    do
      msePathToModule="${MSE_TMP_THIS_MODULE_DIRECTORY}/../${mseDependency}/src/init.sh"
      if [ -f "${msePathToModule}" ]; then
        . "${msePathToModule}"
        MSE_TMP_THIS_MODULE_DIRECTORY=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
      else
        MSE_TMP_ISOK=0
        mse_mod_replacePlaceHolder "MODULE" "${mseDependency}" "${lbl_generic_ModuleNotFound}"
        printf "${msePathToModule}\n"
      fi
    done

    unset mseDependency
    unset msePathToModule
  fi
fi



unset MSE_TMP_THIS_MODULE_NAME
unset MSE_TMP_THIS_MODULE_DIRECTORY
unset MSE_TMP_THIS_MODULE_DEPENDENCY
unset MSE_TMP_ISOK
