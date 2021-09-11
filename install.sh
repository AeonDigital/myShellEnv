#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
# Torne este arquivo executável executando o comando abaixo
# chmod u+x install.sh
#
# Execute assim
# ./install.sh
#
set -eu





#
# Efetua o download de scripts necessários para a instalação.
# Em caso de falha, altera o valor da variável de controle ${ISOK} para "0".
# Sendo bem sucedido irá carregar o script.
#
#   @param string $1
#   Nome do script a ser salvo no diretório temporário 'tmpInstaller'.
#
#   @param string $2
#   Url onde está o arquivo a ser baixado.
#
#   @example
#     downloadInstallScripts "textColors.sh" "textColors.sh"
#
downloadInstallScripts() {
  if [ $# != 2 ]; then
    printf "ERROR in ${FUNCNAME[0]}: expected 2 arguments"
  else
    local mseTMP="${HOME}/tmpInstaller/$1"
    local mseSCode=$(curl -s -w "%{http_code}" -o "${mseTMP}" "$2" || true)

    if [ ! -f "$mseTMP" ] || [ $mseSCode != 200 ]; then
      ISOK=0

      printf "    Não foi possível fazer o download do arquivo de instalação '$1'\n"
      printf "    A instalação foi encerrada.\n"
      printf "    TGT: ${mseTMP} \n"
      printf "    URL: $2 \n\n"
    else
      printf "    > Carregando script: ${mseTMP} \n"
      source "${mseTMP}"
    fi
  fi
}



#
# Efetua o download dos scripts mínimos necessários para efetuar a
# instalação de um pacote 'standAlone'.
#
# Um diretório chamado 'tmpInstaller' será criado no diretório $HOME do
# usuário que iniciou a instalação e nele serão alocados scripts que
# permitem o seguimento da instalação.
#
createTmpInstallerEnv() {

  mkdir -p "${HOME}/tmpInstaller"
  if [ ! -d "${HOME}/tmpInstaller" ]; then
    ISOK=0

    printf "    Não foi possível criar o diretório temporário de instalação. \n"
    printf "    A instalação foi encerrada.\n"
  else
    if [ $ISOK == 1 ]; then
      local mseInstallFiles=(
        "textColors.sh" "alertUser.sh" "errorAlert.sh"
        "waitUser.sh" "promptUser.sh" "setIMessage.sh"
      )

      local mseFileName
      for mseFileName in "${mseInstallFiles[@]}"; do
        if [ $ISOK == 1 ]; then
          downloadInstallScripts "${mseFileName}" "${TMP_URL_INSTALL}functions/interface/${mseFileName}"
        fi
      done
    fi
  fi
}





#
# Efetua o download de todos os scripts necessários para a instalação

ISOK=1

TMP_URL_BASE="https://raw.githubusercontent.com/AeonDigital/myShellEnv/main/"
TMP_URL_ETC="${TMP_URL_BASE}etc/"
TMP_URL_INSTALL="${TMP_URL_BASE}etc/skel/myShellEnv/"

TMP_INSTALL_IN_SKEL=0
TMP_INSTALL_LOGIN_MESSAGE=0
TMP_INSTALL_IN_MY_USER=0


createTmpInstallerEnv
if [ $ISOK == 1 ]; then
  downloadInstallScripts "installMyShellEnv.sh" "${TMP_URL_INSTALL}functions/mseManager/installMyShellEnv.sh"
fi

if [ $ISOK == 1 ]; then
  downloadInstallScripts "downloadMyShellEnvFiles.sh" "${TMP_URL_INSTALL}functions/mseManager/downloadMyShellEnvFiles.sh"
fi





if [ $ISOK == 1 ]; then

  clear
  setIMessage "" 1
  setIMessage "${WHITE}myShellEnv v 1.0 [2021-09-01]${NONE}"
  setIMessage "Iniciando o processo de instalação."
  alertUser



  #
  # sendo um root
  if [ $ISOK == 1 ] && [ $EUID == 0 ]; then
    setIMessage "" 1
    setIMessage "Você foi identificado como um usuário com privilégios ${LBLUE}root${NONE}"
    setIMessage "Isto significa que você tem permissão para instalar o ${LBLUE}myShellEnv${NONE}"
    setIMessage "para ${WHITE}todo novo usuário${NONE} criado nesta máquina."
    alertUser

    setIMessage "\n" 1
    setIMessage "Você deseja instalar a mensagem de login?"
    setIMessage "[ ${DGREY}Ela será vista por todos os usuários!${NONE} ]"

    promptUser
    TMP_INSTALL_LOGIN_MESSAGE=$MSE_GB_PROMPT_RESULT
    MSE_GB_PROMPT_RESULT=""


    setIMessage "\n" 1
    setIMessage "Você deseja fazer uma instalação global (${LBLUE}skel${NONE})?"
    setIMessage "[ ${DGREY}Usuários existentes não serão alterados!${NONE} ]"

    promptUser
    TMP_INSTALL_IN_SKEL=$MSE_GB_PROMPT_RESULT
    MSE_GB_PROMPT_RESULT=""
  fi





  #
  # Verifica se é para efetuar a instalação do 'myShellEnv' para o usuário atual.
  setIMessage "\n" 1
  setIMessage "Prosseguir instalação para o seu próprio usuário?"

  promptUser
  TMP_INSTALL_IN_MY_USER=$MSE_GB_PROMPT_RESULT
  MSE_GB_PROMPT_RESULT=""





  #
  # Sendo para instalar a mensagem de login...
  if [ $ISOK == 1 ] && [ $TMP_INSTALL_LOGIN_MESSAGE == 1 ]; then
    if [ -f "/etc/issue" ]; then
      cp /etc/issue /etc/issue_beforeMyShellEnv
    fi
    mseSCode=$(curl -s -w "%{http_code}" -o /etc/issue "${TMP_URL_ETC}loginMessage" || true)

    if [ ! -f "/etc/issue" ] || [ $mseSCode != 200 ]; then
      ISOK=0

      setIMessage "" 1
      setIMessage "Não foi possível instalar a mensagem de login"
      setIMessage "Processo abortado."
    else
      setIMessage "" 1
      setIMessage "${WHITE}Instalação da mensagem de login concluída${NONE}"
      alertUser
    fi

    unset mseSCode
  fi





  #
  # Sendo para instalar no skel...
  if [ $ISOK == 1 ] && [ $TMP_INSTALL_IN_SKEL == 1 ]; then
    mkdir -p "/etc/skel/myShellEnv"
    if [ ! -d "/etc/skel/myShellEnv" ]; then
      ISOK=0

      setIMessage "\n" 1
      setIMessage "Não foi possível criar o diretório ${LBLUE}/etc/skel/myShellEnv${NONE}?"
      setIMessage "Esta ação foi encerrada.\n"
      alertUser
    else
      installMyShellEnv 1

      if [ $ISOK == 1 ]; then
        setIMessage "" 1
        setIMessage "${WHITE}Instalação no skel concluída${NONE}"
        alertUser
      fi
    fi
  fi





  #
  # Sendo para instalar no no usuário atual...
  if [ $ISOK == 1 ] && [ $TMP_INSTALL_IN_MY_USER == 1 ]; then
    mkdir -p "${HOME}/myShellEnv"
    if [ ! -d "${HOME}/myShellEnv" ]; then
      ISOK=0

      setIMessage "\n" 1
      setIMessage "Não foi possível criar o diretório ${LBLUE}${HOME}/myShellEnv${NONE}?"
      setIMessage "Esta ação foi encerrada.\n"
      alertUser
    else
      installMyShellEnv 0

      if [ $ISOK == 1 ]; then
        setIMessage "" 1
        setIMessage "${WHITE}Instalação para o seu usuário concluída${NONE}"
        alertUser
      fi
    fi
  fi





  #
  # Efetua alterações finais conforme sucesso ou falha da instalação
  if [ $ISOK == 0 ]; then
    setIMessage "" 1
    setIMessage "${LRED}Processo de instalação encerrado com falhas${NONE}"


    if [ $TMP_INSTALL_LOGIN_MESSAGE == 1 ] && [ -f "/etc/issue_beforeMyShellEnv" ]; then
      cp /etc/issue_beforeMyShellEnv /etc/issue
      rm /etc/issue_beforeMyShellEnv
    fi

    if [ $TMP_INSTALL_IN_SKEL == 1 ] && [ -d "/etc/skel/myShellEnv" ]; then
      rm -r "/etc/skel/myShellEnv"
    fi

    if [ $TMP_INSTALL_IN_MY_USER == 1 ] && [ -d "${HOME}/myShellEnv" ]; then
      rm -r "${HOME}/myShellEnv"
    fi
  else
    setIMessage "${LGREEN}Processo de instalação encerrado com sucesso!${NONE}"
    setIMessage "As atualizações serão carregadas no próximo login."
    setIMessage ""

    mseSourceBashRC='source ~/myShellEnv/start.sh || true'

    if [ $TMP_INSTALL_IN_SKEL == 1 ]; then
      if [ -f /etc/skel/.bash_profile ]; then
        echo "source ~/.bashrc" > /etc/skel/.bash_profile
      fi

      if [ -f /etc/skel/.bashrc ]; then
        echo $mseSourceBashRC >> /etc/skel/.bashrc
      else
        echo "[[ \$- != *i* ]] && return\n" > /etc/skel/.bashrc
        echo $mseSourceBashRC >> /etc/skel/.bashrc
      fi
    fi

    if [ $TMP_INSTALL_IN_MY_USER == 1 ]; then
      if [ -f "${HOME}/.bash_profile" ]; then
        echo "source ~/.bashrc" > "${HOME}/.bash_profile"
      fi

      if [ -f ${HOME}/.bashrc ]; then
        echo $mseSourceBashRC >> "${HOME}/.bashrc"
      else
        echo "[[ \$- != *i* ]] && return\n" > "${HOME}/.bashrc"
        echo $mseSourceBashRC >> "${HOME}/.bashrc"
      fi
    fi

    unset mseSourceBashRC
  fi



  rm -r "${HOME}/tmpInstaller"
  if [ -f install.sh ]; then
    rm install.sh
  fi
  if [ -f myShellEnvInstall.sh ]; then
    rm myShellEnvInstall.sh
  fi
  waitUser
fi




unset TMP_URL_BASE
unset TMP_URL_ETC
unset TMP_URL_INSTALL
unset TMP_INSTALL_IN_SKEL
unset TMP_INSTALL_LOGIN_MESSAGE
unset TMP_INSTALL_IN_MY_USER


unset downloadInstallScripts
unset createTmpInstallerEnv
