#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
MSE_GB_URL_BASE="https://raw.githubusercontent.com/AeonDigital/myShellEnv/main/"
MSE_GB_URL_ETC="${MSE_GB_URL_BASE}etc/"
MSE_GB_URL_INSTALL="${MSE_GB_URL_BASE}etc/skel/myShellEnv/"



#
# Efetua o download e instalação dos arquivos necessários para
# o funcionamento do 'myShellEnv'.
#
#   @param bool $1
#   Use '1' para instalar os scripts no 'skel' ou '0' para
#   instalar no ambiente do usuário atualmente logado.
#
installMyShellEnv() {
  if [ $# != 1 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 arguments"
  else

    local mseIsSkel=0
    if [ $1 == 1 ] || [ $1 == 0 ]; then
      mseIsSkel=$1
    fi

    local mseTargetDir="${HOME}/myShellEnv/"
    if [ $mseIsSkel == 1 ]; then
      mseTargetDir="/etc/skel/myShellEnv/"
    fi


    # Básico
    if [ $ISOK == 1 ]; then
      MSE_GB_TARGET_FILES=("start.sh" "config.sh")
      downloadMyShellEnvFiles "$MSE_GB_URL_INSTALL" "$mseTargetDir"
    fi

    local mseDir
    local mseURL

    # Funções
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}functions/mseManager/"
      mseURL="${MSE_GB_URL_INSTALL}functions/mseManager/"
      MSE_GB_TARGET_FILES=(
        "installMyShellEnv.sh" "downloadMyShellEnvFiles.sh"
        "updateMyShellEnv.sh" "uninstallMyShellEnv.sh"
      )
      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Funções :: interface
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}functions/interface/"
      mseURL="${MSE_GB_URL_INSTALL}functions/interface/"
      MSE_GB_TARGET_FILES=(
        "alertUser.sh" "aliases.sh" "errorAlert.sh" "promptUser.sh"
        "setIMessage.sh" "textColors.sh" "waitUser.sh"
      )
      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Funções :: string
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}functions/string/"
      mseURL="${MSE_GB_URL_INSTALL}functions/string/"
      MSE_GB_TARGET_FILES=(
        "toLowerCase.sh" "toUpperCase.sh"
        "trim.sh" "trimD.sh" "trimDL.sh" "trimDR.sh" "trimL.sh" "trimR.sh"
      )
      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Funções :: terminal
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}functions/terminal/"
      mseURL="${MSE_GB_URL_INSTALL}functions/terminal/"
      MSE_GB_TARGET_FILES=("setUTF8.sh" "promptConfig.sh")
      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Funções :: thirdPart
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}functions/thirdPart/"
      mseURL="${MSE_GB_URL_INSTALL}functions/thirdPart/"
      MSE_GB_TARGET_FILES=("print256colours.sh" "printASCIIEChars.sh")
      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Funções :: tools
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}functions/tools/"
      mseURL="${MSE_GB_URL_INSTALL}functions/tools/"
      MSE_GB_TARGET_FILES=("setConfiguration.sh")
      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi

  fi
}
