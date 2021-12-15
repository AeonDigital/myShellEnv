#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Variáveis
MSE_GB_URL_BASE="https://raw.githubusercontent.com/AeonDigital/myShellEnv/main/"
MSE_GB_URL_ETC="${MSE_GB_URL_BASE}etc/"
MSE_GB_URL_INSTALL="${MSE_GB_URL_BASE}etc/skel/myShellEnv/"



#
# Efetua o download e instalação dos arquivos necessários para
# o funcionamento do 'myShellEnv'.
#
#   @param mixed $1
#   Use '1' para instalar os scripts no 'skel'.
#   Use '0' para instalar no ambiente do usuário atualmente logado.
#   Use 'u' para atualizar os arquivos do usuário atualmente logado.
#
installMyShellEnv() {
  if [ $# != 1 ]; then
    errorAlert "${FUNCNAME[0]}" "expected 1 arguments"
  else

    local mseTargetDir="${HOME}/myShellEnv/"
    if [ $1 == 1 ]; then
      mseTargetDir="/etc/skel/myShellEnv/"
    fi

    if [ $1 == 'u' ]; then
      mseTargetDir="${HOME}/myShellEnvUpdate/"
      mkdir -p "${HOME}/myShellEnvUpdate"

      if [ ! -d "${HOME}/myShellEnvUpdate" ]; then
        ISOK=0
        errorAlert "${FUNCNAME[0]}" "temp directory cannot be created"
      fi
    fi



    # Básico
    if [ $ISOK == 1 ]; then
      MSE_GB_TARGET_FILES=("start.sh" "config.sh")

      rm -r "$mseTargetDir"
      downloadMyShellEnvFiles "$MSE_GB_URL_INSTALL" "$mseTargetDir"
    fi

    local mseDir
    local mseURL


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


    # Funções :: thirdPart
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}functions/thirdPart/"
      mseURL="${MSE_GB_URL_INSTALL}functions/thirdPart/"
      MSE_GB_TARGET_FILES=("print256colours.sh")

      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Funções :: tools
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}functions/tools/"
      mseURL="${MSE_GB_URL_INSTALL}functions/tools/"
      MSE_GB_TARGET_FILES=(
        "convertCharToDecimal.sh" "convertCharToHex.sh" "convertCharToOctal.sh"
        "convertDecimalToChar.sh" "convertDecimalToHex.sh" "convertDecimalToOctal.sh"
        "convertHexToChar.sh" "convertHexToDecimal.sh" "convertHexToOctal.sh"
        "convertOctalToChar.sh" "convertOctalToDecimal.sh" "convertOctalToHex.sh"
      )

      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi





    # Gerenciamento :: configuração
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}management/config_files/"
      mseURL="${MSE_GB_URL_INSTALL}management/config_files/"
      MSE_GB_TARGET_FILES=(
        "mcfCommentSectionVariable.sh" "mcfCommentVariable.sh" "mcfPrintSectionVariable.sh"
        "mcfPrintSectionVariableInfo.sh" "mcfPrintSectionVariables.sh" "mcfPrintSectionVariableValue.sh"
        "mcfPrintVariable.sh" "mcfPrintVariableInfo.sh" "mcfPrintVariables.sh"
        "mcfPrintVariableValue.sh" "mcfSetArrayValues.sh" "mcfSetSectionVariable.sh"
        "mcfSetVariable.sh" "mcfUncommentSectionVariable.sh" "mcfUncommentVariable.sh"
      )

      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Gerenciamento :: instalação/atualização
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}management/instalation/"
      mseURL="${MSE_GB_URL_INSTALL}management/instalation/"
      MSE_GB_TARGET_FILES=(
        "downloadMyShellEnvFiles.sh" "installMyShellEnv.sh"
        "uninstallMyShellEnv.sh" "updateMyShellEnv.sh"
      )

      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Gerenciamento :: terminal
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}management/terminal/"
      mseURL="${MSE_GB_URL_INSTALL}management/terminal/"
      MSE_GB_TARGET_FILES=(
        "listTerminalFonts.sh" "printCharTable.sh"
        "promptTools.sh" "setTerminalUTF8.sh"
      )

      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi


    # Gerenciamento :: terminal :: config
    if [ $ISOK == 1 ]; then
      mseDir="${mseTargetDir}management/terminal/config/"
      mseURL="${MSE_GB_URL_INSTALL}management/terminal/config/"
      MSE_GB_TARGET_FILES=(
        "promptConfig.sh" "promptStyles.sh"
      )

      downloadMyShellEnvFiles "$mseURL" "$mseDir"
    fi
  fi
}
