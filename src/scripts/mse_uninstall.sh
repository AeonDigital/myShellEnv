#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# @desc
# Desinstala o 'myShellEnv'.
#
# @param bool $1
# Use '0' ou omita este parametro para desinstalar apenas a
# instância do seu usuário.
# Use '1' se deseja desinstalar a instância global existente
# no '/etc/skel'. Esta opção apenas funciona se for usada
# como 'sudo' e não irá desinstalar as instâncias individuais
# de cada usuário.
mse_uninstall() {
  local mseIsOk=1
  local mseTarget="user"
  local mseInstallationPath="${HOME}"
  if [ $# == 1 ] && [ $1 == 1 ]; then
    mseTarget="global"
    mseInstallationPath="/etc/skel"
  fi


  #
  # se o usuário não é 'root' não permite a desinstalação
  # da versão global.
  if [ $EUID != 0 ] && [ "${mseTarget}" == "global" ]; then
    mseIsOk=0

    mse_mmod_setIMessage "" 1
    mse_mmod_setIMessage "${mseLRED}${lbl_mse_uninstall_fail_FAIL}${mseNONE}\n"
    mse_mmod_setIMessage "${lbl_mse_uninstall_fail_notAllowed}"
    mse_mmod_setIMessage ""
    mse_mmod_alertUser
  else

    #
    # Confere se a instalação está mesmo no local esperado
    if [ ! -d "${mseInstallationPath}/.myShellEnv/src/bashrcBackup" ]; then
      mseIsOk=0

      mse_mmod_setIMessage "" 1
      mse_mmod_setIMessage "${mseLRED}${lbl_mse_uninstall_fail_FAIL}${mseNONE}\n"
      mse_mmod_setIMessage "${lbl_mse_uninstall_fail_directoryNotFound}"
      mse_mmod_setIMessage "${mseInstallationPath}/.myShellEnv"
      mse_mmod_setIMessage ""
      mse_mmod_alertUser
    else

      #
      # Primeiramente identifica o backup do bashrc
      # para que ele seja restaurado
      local mseBashrcBackups=$(find "${mseInstallationPath}/.myShellEnv/src/bashrcBackup/" -maxdepth 1 -name "bashrc-mse-backup-*")
      if [ "$mseBashrcBackups" != "" ]; then
        local rawFiles
        local mseFullFileName
        local mseExtension
        local mseFilename
        local mseFileDate

        local mseSelectedBackupPath=""
        local mseSelectedBackupDate=0


        #
        # Identifica o arquivo do backup mais recente
        while read rawFiles
        do
          mseFullFileName=$(basename -- "$rawFiles")
          mseExtension="${mseFullFileName##*.}"
          mseFilename="${mseFullFileName%.*}"
          mseFileDate=$(mse_str_replace "-" "" "${mseFilename/bashrc-mse-backup-/""}")

          if [ "${mseSelectedBackupPath}" == "" ] || [ $mseFileDate -ge $mseSelectedBackupDate ]; then
            mseSelectedBackupPath="${rawFiles}"
            mseSelectedBackupDate="${mseFileDate}"
          fi
        done <<< ${mseBashrcBackups}

        #
        # Recupera o .bashrc a partir dos backups
        mv "${mseSelectedBackupPath}" "${mseInstallationPath}/.bashrc"
        if [ $? != 0 ]; then
          mseIsOk=0

          mse_mmod_setIMessage "" 1
          mse_mmod_setIMessage "${mseLRED}${lbl_mse_uninstall_fail_FAIL}${mseNONE}\n"
          mse_mmod_setIMessage "${lbl_mse_uninstall_fail_restoreBashrc}"
          mse_mmod_setIMessage "${lbl_mse_uninstall_fail_checkPermission}"
          mse_mmod_setIMessage "${lbl_mse_uninstall_fail_restoreBashrcPresentFile}"
          mse_mmod_setIMessage "${mseSelectedBackupPath}"
          mse_mmod_setIMessage ""
          mse_mmod_alertUser
        else

          #
          # remove o diretório da instalação
          rm -rf "${mseInstallationPath}/.myShellEnv"
          if [ $? != 0 ]; then
            mse_mmod_setIMessage "" 1
            mse_mmod_setIMessage "${mseLRED}${lbl_mse_uninstall_fail_FAIL}${mseNONE}\n"
            mse_mmod_setIMessage "${lbl_mse_uninstall_fail_cannotRemoveDirectory}"
            mse_mmod_setIMessage "${mseInstallationPath}/.myShellEnv"
            mse_mmod_setIMessage "${lbl_mse_uninstall_fail_checkPermission}"
            mse_mmod_setIMessage "${lbl_mse_uninstall_fail_tryManually}"
            mse_mmod_setIMessage ""
            mse_mmod_setIMessage "${lbl_mse_uninstall_fail_ATTENTION}"
            mse_mmod_setIMessage "${lbl_mse_uninstall_success_restoreBashrc}"
            mse_mmod_setIMessage ""
            mse_mmod_alertUser
          else
            mse_mmod_setIMessage "" 1
            mse_mmod_setIMessage "${mseLBLUE}${lbl_mse_uninstall_success_SUCCESS}${mseNONE}"
            mse_mmod_setIMessage "${mseDGREY}${lbl_mse_uninstall_success_completed}${mseNONE}"
            mse_mmod_alertUser
          fi

        fi
      fi
    fi
  fi


  if [ $mseIsOk == 0 ]; then
    mse_mmod_setIMessage "${lbl_mse_uninstall_fail_endMsg}" 1
    mse_mmod_alertUser
  fi
}
