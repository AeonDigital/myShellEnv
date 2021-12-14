#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Remove completamente o 'myShellEnv' do seu sistema ou do seu
# usuário, conforme indicado nos parametros.
#
# Você também pode restaurar a mensagem de login original, anterior
# ao momento em que o 'myShellEnv' foi instalado.
#
#   @param string $1
#   Use 'user' para desinstalar apenas do seu usuário.
#   Ou, use 'skel' para desinstalar do skel (exige root).
#
#   @param bool $2
#   Use '1' para desinstalar a mensagem de login.
#   Use '0', ou, omita este parametro, para não alterá-la.
#
uninstallMyShellEnv() {
  ISOK=1
  local mseUninstallLoginMessage=0

  if [ $# != 1 ] && [ $# != 2 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 or 2 arguments"
  else

    if [ $1 != "user" ] && [ $1 != "skel" ]; then
      ISOK=0
      errorAlert "${FUNCNAME[0]}" "Invalid argument 1" "expected 'user' or 'system'"
    else
      if [ $1 == "skel" ] && [ $EUID != 0 ]; then
        ISOK=0
        errorAlert "${FUNCNAME[0]}" "need elevate privileges to perform this action."
      fi
    fi


    if [ $ISOK == 1 ] && [ $# == 2 ]; then
      if [ $2 != 0 ] && [ $2 != 1 ]; then
        ISOK=0
        errorAlert "${FUNCNAME[0]}" "Invalid argument 2" "expected '0' or '1'"
      else
        mseUninstallLoginMessage=$2
      fi
    fi


    if [ $ISOK == 1 ]; then

      setIMessage "" 1
      setIMessage "${WHITE}Iniciando a desinstalação!${NONE}"
      setIMessage "[ ${DGREY}Esta ação é irreversível.${NONE} ]"
      setIMessage "Deseja mesmo prosseguir?"

      promptUser
      if [ $MSE_GB_PROMPT_RESULT == 0 ]; then
        setIMessage "" 1
        setIMessage "${WHITE}Ação abortada pelo usuário!${NONE}"
        alertUser
      else
        setIMessage "... " 1
        local mseSourceBashRC='source ~\/myShellEnv\/start.sh || true'

        if [ $mseUninstallLoginMessage == 1 ] && [ -f "/etc/issue_beforeMyShellEnv" ]; then
          setIMessage "... Redefinindo a mensagem original de login."
          cp /etc/issue_beforeMyShellEnv /etc/issue
          rm /etc/issue_beforeMyShellEnv
        fi

        if [ $1 == "skel" ]; then
          setIMessage "... Removendo o ${WHITE}myShellEnv${NONE} do ${LBLUE}skel${NONE}."
          rm -r /etc/skel/myShellEnv
          sed -i "s/${mseSourceBashRC}//g" /etc/skel/.bashrc
        fi

        if [ $1 == "user" ]; then
          setIMessage "... Removendo o ${WHITE}myShellEnv${NONE} do seu usuário."
          rm -r "${HOME}/myShellEnv"
          sed -i "s/${mseSourceBashRC}//g" "${HOME}/.bashrc"
        fi

        setIMessage "Processo finalizado"
        alertUser
      fi

      MSE_GB_PROMPT_RESULT=""

    fi
  fi
}
