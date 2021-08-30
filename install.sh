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
    TMP="${HOME}/tmpInstaller/$1"
    curl -s -o "${TMP}" "$2" || true

    if [ ! -f "$TMP" ]; then
      ISOK=0

      printf "Não foi possível fazer o download do arquivo de instalação '$1'\n"
      printf "A instalação foi encerrada.\n"
      printf "URL: $2 \n"
      printf "TGT: ${TMP} \n"
    else
      printf " > Carregando script: ${TMP} \n"
      source "${TMP}"
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

    printf "Não foi possível criar o diretório temporário de instalação. \n"
    printf "A instalação foi encerrada.\n"
  else
    if [ $ISOK == 1 ]; then
      INSTALL_FILES=(
        "textColors.sh" "alertUser.sh" "errorAlert.sh"
        "waitUser.sh" "promptUser.sh" "setIMessage.sh"
      )

      for fileName in "${INSTALL_FILES[@]}"; do
        if [ $ISOK == 1 ]; then
          downloadInstallScripts "${fileName}" "${URL_INSTALL}functions/interface/${fileName}"
        fi
      done
    fi
  fi
}





#
# Efetua o download de todos os scripts necessários para a instalação

URL_BASE="https://raw.githubusercontent.com/AeonDigital/myShellEnv/master/"
URL_ETC="${URL_BASE}shell/etc/"
URL_INSTALL="${URL_BASE}shell/etc/skel/myShellEnv/"

ISOK=1

createTmpInstallerEnv
if [ $ISOK == 1 ]; then
  downloadInstallScripts "installMyShellEnv.sh" "${URL_INSTALL}functions/installMyShellEnv.sh"
fi

if [ $ISOK == 1 ]; then
  downloadInstallScripts "downloadMyShellEnvFiles.sh" "${URL_INSTALL}functions/downloadMyShellEnvFiles.sh"
fi





if [ $ISOK == 1 ]; then

  clear
  setIMessage "" 1
  setIMessage "${SILVER}myShellEnv v 0.9.10 [2021-08-30]${NONE}"
  setIMessage "Iniciando o processo de instalação."
  alertUser


  INSTALL_IN_SKEL=0
  INSTALL_LOGIN_MESSAGE=0
  INSTALL_IN_MY_USER=0



  #
  # sendo um root
  if [ $ISOK == 1 ] && [ "$EUID" == 0 ]; then
    setIMessage "" 1
    setIMessage "Você foi identificado como um usuário com privilégios ${LBLUE}root${NONE}"
    setIMessage "Isto significa que você tem permissão para instalar o ${LBLUE}myShellEnv${NONE}"
    setIMessage "para ${SILVER}todo novo usuário${NONE} criado nesta máquina."
    alertUser

    setIMessage "\n" 1
    setIMessage "Você deseja instalar a mensagem de login?"
    setIMessage "[ ${DGREY}Ela será vista por todos os usuários!${NONE} ]"

    promptUser
    INSTALL_LOGIN_MESSAGE=$PROMPT_RESULT
    PROMPT_RESULT=""


    setIMessage "\n" 1
    setIMessage "Você deseja fazer uma instalação global (${LBLUE}skel${NONE})?"
    setIMessage "[ ${DGREY}Usuários existentes não serão alterados!${NONE} ]"

    promptUser
    INSTALL_IN_SKEL=$PROMPT_RESULT
    PROMPT_RESULT=""
  fi





  #
  # Verifica se é para efetuar a instalação do 'myShellEnv' para o usuário atual.
  setIMessage "\n" 1
  setIMessage "Prosseguir instalação para o seu próprio usuário?"

  promptUser
  INSTALL_IN_MY_USER=$PROMPT_RESULT
  PROMPT_RESULT=""





  #
  # Sendo para instalar a mensagem de login...
  if [ $ISOK == 1 ] && [ "$INSTALL_LOGIN_MESSAGE" == "1" ]; then
    if [ -f "/etc/issue" ]; then
      cp /etc/issue /etc/issue_beforeMyShellEnv
    fi
    curl -s -o /etc/issue "${URL_ETC}loginMessage" || true

    if [ ! -f "/etc/issue" ]; then
      ISOK=0

      setIMessage "" 1
      setIMessage "Não foi possível instalar a mensagem de login"
      setIMessage "Processo abortado."
    else
      setIMessage "" 1
      setIMessage "${SILVER}Instalação da mensagem de login concluída${NONE}"
      alertUser
    fi
  fi





  #
  # Sendo para instalar no skel...
  if [ $ISOK == 1 ] && [ "$INSTALL_IN_SKEL" == "1" ]; then
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
        setIMessage "${SILVER}Instalação no skel concluída${NONE}"
        alertUser
      fi
    fi
  fi





  #
  # Sendo para instalar no no usuário atual...
  if [ $ISOK == 1 ] && [ "$INSTALL_IN_MY_USER" == "1" ]; then
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
        setIMessage "${SILVER}Instalação para o seu usuário concluída${NONE}"
        alertUser
      fi
    fi
  fi





  #
  # Efetua alterações finais conforme sucesso ou falha da instalação
  if [ $ISOK == 0 ]; then
    setIMessage "" 1
    setIMessage "${LRED}Processo de instalação encerrado com falhas${NONE}"


    if [ "$INSTALL_LOGIN_MESSAGE" == "1" ] && [ -f "/etc/issue_beforeMyShellEnv" ]; then
      cp /etc/issue_beforeMyShellEnv /etc/issue
      rm /etc/issue_beforeMyShellEnv
    fi

    if [ "$INSTALL_IN_SKEL" == "1" ]; then
      rm -r "/etc/skel/myShellEnv"
    fi

    if [ "$INSTALL_IN_MY_USER" == "1" ]; then
      rm -r "${HOME}/myShellEnv"
    fi
  else
    setIMessage "${LRED}Processo de instalação encerrado com sucesso!${NONE}"
    setIMessage "As atualizações serão carregadas no próximo login."
    setIMessage ""

    SOURCE_BASHRC='source ~/myShellEnv/start.sh || true'

    if [ "$INSTALL_IN_SKEL" == "1" ]; then
      echo $SOURCE_BASHRC >> /etc/skel/.bashrc
    fi

    if [ "$INSTALL_IN_MY_USER" == "1" ]; then
      echo $SOURCE_BASHRC >> ${HOME}/.bashrc
    fi
  fi



  rm -R "${HOME}/tmpInstaller"
  rm installMyShellEnv.sh
  waitUser
fi
