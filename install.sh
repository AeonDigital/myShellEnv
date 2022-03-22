#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
# Torne este arquivo executável usando :
# > chmod u+x install.sh
#
# Execute assim
# > ./install.sh






set -eu
ISOK=1
MSE_TMP_INSTALL_INDENT="    "
MSE_TMP_INSTALL_INTERFACE_MSG=()
MSE_TMP_INSTALL_PROMPT_RESULT=""

MSE_TMP_INSTALL_COLOR_NONE=""
MSE_TMP_INSTALL_COLOR_HIGHLIGHT=""
MSE_TMP_INSTALL_COLOR_CONTRAST=""
MSE_TMP_INSTALL_COLOR_ERROR=""

MSE_TMP_INSTALL_OPTIONS_GLOBAL=0
MSE_TMP_INSTALL_OPTIONS_CURRENT_USER=0
MSE_TMP_INSTALL_OPTIONS_LOGIN_MESSAGE=0 # não usado

MSE_TMP_INSTALLATION_PATH="${HOME}"
MSE_TMP_INSTALL_PATH_TO_HOME="${HOME}"
MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP="${MSE_TMP_INSTALLATION_PATH}/.myShellEnv/src/bashrcBackup/bashrc-mse-backup-$(date +%Y-%m-%d-%H-%M-%S)"





#
# Mostra uma mensagem de alerta para o usuário.
mse_install_alertUser() {
  if [ ${#MSE_TMP_INSTALL_INTERFACE_MSG[@]} -gt 0 ]; then
    local mseMsg

    printf "\n"
    for mseMsg in "${MSE_TMP_INSTALL_INTERFACE_MSG[@]}"; do
      printf "${MSE_TMP_INSTALL_INDENT}${mseMsg}\n"
    done

    MSE_TMP_INSTALL_INTERFACE_MSG=()
  fi
}

#
# Mostra uma mensagem para o usuário e permite que ele
# ofereça uma resposta booleana.
mse_install_promptUser() {
  MSE_TMP_INSTALL_PROMPT_RESULT=""
  local msePromptValidInputs=("yes" "y" "no" "n")
  local msePromptValue=""

  if [ ${#MSE_TMP_INSTALL_INTERFACE_MSG[@]} -gt 0 ]; then
    mse_install_alertUser

    #
    # Efetua um loop recebendo valores do usuário até que seja digitado algum válido.
    while [ "$MSE_TMP_INSTALL_PROMPT_RESULT" == "" ]; do
      if [ "$msePromptValue" != "" ]; then
        printf "${MSE_TMP_INSTALL_INDENT}Invalid value\n"
      fi

      #
      # Permite que o usuário digite sua resposta
      read -p "${MSE_TMP_INSTALL_INDENT}confirm [ yes/y/no/n ] : " msePromptValue

      #
      # Verifica se o valor digitado corresponde a algum dos valores válidos.
      msePromptValue=$(printf "$msePromptValue" | awk '{print tolower($0)}')
      if [ "$msePromptValue" == "yes" ] || [ "$msePromptValue" == "y" ]; then
        MSE_TMP_INSTALL_PROMPT_RESULT=1
      elif [ "$msePromptValue" == "no" ] || [ "$msePromptValue" == "n" ]; then
        MSE_TMP_INSTALL_PROMPT_RESULT=0
      fi
    done
  fi
}

#
# Verifica se um comando indicado existe.
mse_install_checkIfCommandExists() {
  $1 &> /dev/null
  if [ $? == 0 ]; then printf "1"; else printf "0"; fi
}

#
# Efetua a instalação no diretório indicado
mse_install_myShellEnv() {
  local mseFromSkel=0
  if [ $# == 1 ] && [ $1 == 1 ]; then
    mseFromSkel=1
  fi



  if [ -d "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv" ]; then
    ISOK=0

    MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}FAIL!${MSE_TMP_INSTALL_COLOR_NONE}\n")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("There is already a version of \"myShellEnv\" installed in")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALLATION_PATH}/.myShellEnv")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("Uninstall the previous version to install a new one.")
  else

    #
    # Cria o diretório de instalação
    mkdir -p "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv"
    if [ ! -d "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv" ]; then
      ISOK=0

      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}FAIL!${MSE_TMP_INSTALL_COLOR_NONE}\n")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Could not create installation directory")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALLATION_PATH}/.myShellEnv")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Please check permissions and try again.")
    else

      #
      # Inicia a instalação do repositório
      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}Cloning repository${MSE_TMP_INSTALL_COLOR_NONE}")
      mse_install_alertUser

      if [ $mseFromSkel == 0 ]; then
        $(git clone --depth=1 https://github.com/AeonDigital/myShellEnv.git "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv")
        $(git -C "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv" submodule init)
        $(git -C "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv" submodule update --remote)
      else
        cp -r "/etc/skel/.myShellEnv" "${MSE_TMP_INSTALL_PATH_TO_HOME}"
        rm "${MSE_TMP_INSTALL_PATH_TO_HOME}/.myShellEnv/src/bashrcBackup/bashrc*"
      fi


      #
      # Verifica se a instalação foi ok
      if [ ! -d "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv/src" ]; then
        ISOK=0

        MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}FAIL!${MSE_TMP_INSTALL_COLOR_NONE}\n")
        MSE_TMP_INSTALL_INTERFACE_MSG+=("Could not clone repository.")
      else
        MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}clone ok!${MSE_TMP_INSTALL_COLOR_NONE}")
        mse_install_alertUser

        #
        # Gera uma cópia do '.bashrc' do local da instalação
        if [ -f "${MSE_TMP_INSTALLATION_PATH}/.bashrc" ] || [ -h "${MSE_TMP_INSTALLATION_PATH}/.bashrc" ]; then
          MSE_TMP_INSTALL_INTERFACE_MSG+=("Creating backup of ${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}.bashrc${MSE_TMP_INSTALL_COLOR_NONE}")
          MSE_TMP_INSTALL_INTERFACE_MSG+=("copying to ${MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP}")
          mse_install_alertUser

          mv "${MSE_TMP_INSTALLATION_PATH}/.bashrc" "${MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP}"
          if [ $? != 0 ]; then
            ISOK=0

            MSE_TMP_INSTALL_INTERFACE_MSG+=("Could not save your ${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}.bashrc${MSE_TMP_INSTALL_COLOR_NONE} backup.")
            MSE_TMP_INSTALL_INTERFACE_MSG+=("Please check permissions and try again.")
          fi
        fi


        if [ $ISOK == 1 ]; then
          #
          # Adiciona o novo '.bashrc'
          cp "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv/src/templates/.bashrc" "${MSE_TMP_INSTALLATION_PATH}/.bashrc"
          if [ $? != 0 ]; then
            ISOK=0

            MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}FAIL!${MSE_TMP_INSTALL_COLOR_NONE}\n")
            MSE_TMP_INSTALL_INTERFACE_MSG+=("Could not install ${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}.bashrc${MSE_TMP_INSTALL_COLOR_NONE} file in the indicated location:")
            MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALLATION_PATH}/.bashrc")
            MSE_TMP_INSTALL_INTERFACE_MSG+=("Please check permissions and try again.")
          fi
        fi

      fi


      #
      # Se uma falha ocorrer, remove a instalação
      if [ $ISOK == 0 ]; then
        mse_remove_failedInstallation
      fi
    fi

  fi
}

#
# Remove a instalação do diretório indicado
mse_remove_failedInstallation() {
  local mseTmpRemoveInstallationPath=1

  #
  # Restaura o .bashrc
  if [ "${MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP}" != "" ] && [ -f "${MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP}" ]; then
    mv "${MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP}" "${MSE_TMP_INSTALLATION_PATH}/.bashrc"

    if [ $? != 0 ]; then
      mseTmpRemoveInstallationPath=0

      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}Attention!${MSE_TMP_INSTALL_COLOR_NONE}")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Installation failed and your ${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}.bashrc${MSE_TMP_INSTALL_COLOR_NONE} file could not be restored.")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("But do not worry. A copy of it is saved in:")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP}")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Before trying a new installation try to restore it manually")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("and then delete the directory indicated below")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALLATION_PATH}/.myShellEnv")
      mse_install_alertUser
    fi
  fi

  #
  # remove o diretório da instalação
  if [ $mseTmpRemoveInstallationPath == 1 ] && [ -d "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv" ]; then
    rm -rf "${MSE_TMP_INSTALLATION_PATH}/.myShellEnv"

    if [ $? != 0 ]; then
      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}Attention!${MSE_TMP_INSTALL_COLOR_NONE}")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Installation failed and could not remove cloned repository:")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALLATION_PATH}/.myShellEnv")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Before trying a new installation you need to manually remove it")
      mse_install_alertUser
    fi
  fi
}





#
# Define as cores se for possível de utilizá-las
if [ ! -z "${BASH_VERSION-}" ] && [ -t 1 ]; then
  MSE_TMP_TERMINAL_N_COLORS="$(tput colors 2> /dev/null || tput Co 2> /dev/null || echo -1)"

  if [ -n "$MSE_TMP_TERMINAL_N_COLORS" ] && [ $MSE_TMP_TERMINAL_N_COLORS -ge 8 ]; then
    MSE_TMP_INSTALL_COLOR_NONE='\e[0;37;37m'
    MSE_TMP_INSTALL_COLOR_HIGHLIGHT='\e[0;37;94m'
    MSE_TMP_INSTALL_COLOR_CONTRAST='\e[0;37;90m'
    MSE_TMP_INSTALL_COLOR_ERROR='\e[0;37;91m'
  fi

  unset MSE_TMP_TERMINAL_N_COLORS
fi





#
# Identifica se a versão mínima do bash é a que está rodando
# e se as dependencias da instalação está presentes.
if [ -z "${BASH_VERSION-}" ]; then
  ISOK=0
  MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}FAIL!${MSE_TMP_INSTALL_COLOR_NONE}\n")
  MSE_TMP_INSTALL_INTERFACE_MSG+=("Bash 5.0 required")
else
  MSE_TMP_INSTALL_BASH_REQUIRED_MAJOR_VERSION=5
  MSE_TMP_INSTALL_BASH_REQUIRED_MINOR_VERSION=0
  MSE_TMP_INSTALL_BASH_REQUIRED_COMPARE_VERSION="${MSE_TMP_INSTALL_BASH_REQUIRED_MAJOR_VERSION}${MSE_TMP_INSTALL_BASH_REQUIRED_MINOR_VERSION}"

  MSE_TMP_INSTALLED_BASH_MAJOR_VERSION="${BASH_VERSINFO[0]}"
  MSE_TMP_INSTALLED_BASH_MINOR_VERSION="${BASH_VERSINFO[1]}"
  MSE_TMP_INSTALLED_BASH_COMPARE_VERSION="${MSE_TMP_INSTALLED_BASH_MAJOR_VERSION}${MSE_TMP_INSTALLED_BASH_MINOR_VERSION}"

  if [ ${MSE_TMP_INSTALLED_BASH_COMPARE_VERSION} -lt ${MSE_TMP_INSTALL_BASH_REQUIRED_COMPARE_VERSION} ]; then
    ISOK=0

    MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}FAIL!${MSE_TMP_INSTALL_COLOR_NONE}\n")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("Your Bash version is recognized as ${MSE_TMP_INSTALLED_BASH_MAJOR_VERSION}.${MSE_TMP_INSTALLED_BASH_MINOR_VERSION}")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("and the required by this installation is ${MSE_TMP_INSTALL_BASH_REQUIRED_MAJOR_VERSION}.${MSE_TMP_INSTALL_BASH_REQUIRED_MINOR_VERSION}")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("Upgrade your Bash and try again")
  else
    MSE_TMP_GIT=$(mse_install_checkIfCommandExists "git --version")

    if [ $MSE_TMP_GIT == 0 ]; then
      ISOK=0

      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}FAIL!${MSE_TMP_INSTALL_COLOR_NONE}\n")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Git not found.")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Install and try again.")
    fi

    unset MSE_TMP_GIT
  fi

  unset MSE_TMP_INSTALL_BASH_REQUIRED_MAJOR_VERSION
  unset MSE_TMP_INSTALL_BASH_REQUIRED_MINOR_VERSION
  unset MSE_TMP_INSTALL_BASH_REQUIRED_COMPARE_VERSION

  unset MSE_TMP_INSTALLED_BASH_MAJOR_VERSION
  unset MSE_TMP_INSTALLED_BASH_MINOR_VERSION
  unset MSE_TMP_INSTALLED_BASH_COMPARE_VERSION
fi





#
# Não havendo erros até aqui, prossegue a instalação
if [ $ISOK == 1 ]; then
  clear
  MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}myShellEnv v 1.0${MSE_TMP_INSTALL_COLOR_NONE}")
  MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_CONTRAST}Starting installation${MSE_TMP_INSTALL_COLOR_NONE}")
  mse_install_alertUser


  #
  # Se o usuário atual é um root
  if [ $EUID == 0 ]; then

    MSE_TMP_INSTALL_INTERFACE_MSG+=("You have been identified as a user with ${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}root${MSE_TMP_INSTALL_COLOR_NONE} privileges")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("you are allowed to install \"myShellEnv\" ${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}globally${MSE_TMP_INSTALL_COLOR_NONE}.")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("With this ${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}every new user${MSE_TMP_INSTALL_COLOR_NONE} will be created with their own \"myShellEnv\" installation.")
    mse_install_alertUser

    MSE_TMP_INSTALL_INTERFACE_MSG+=("Do you want to do a global install?")
    MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_CONTRAST}Existing users will not be changed${MSE_TMP_INSTALL_COLOR_NONE}")
    mse_install_promptUser

    MSE_TMP_INSTALL_OPTIONS_GLOBAL=${MSE_TMP_INSTALL_PROMPT_RESULT}
    if [ ${MSE_TMP_INSTALL_OPTIONS_GLOBAL} == 1 ]; then
      MSE_TMP_INSTALLATION_PATH="/etc/skel"
      MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP="${MSE_TMP_INSTALLATION_PATH}/.myShellEnv/src/bashrcBackup/bashrc-mse-backup-$(date +%Y-%m-%d-%H-%M-%S)"

      if [ ! -d "$MSE_TMP_INSTALLATION_PATH" ] || [ ! -x "$MSE_TMP_INSTALLATION_PATH" ]; then
        ISOK=0

        MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_ERROR}FAIL!${MSE_TMP_INSTALL_COLOR_NONE}\n")
        MSE_TMP_INSTALL_INTERFACE_MSG+=("The global installation path was not found")
        MSE_TMP_INSTALL_INTERFACE_MSG+=("or you do not have permission to access it")
        MSE_TMP_INSTALL_INTERFACE_MSG+=("path: ${MSE_TMP_INSTALLATION_PATH}")
        mse_install_alertUser
      fi
    fi



    if [ $ISOK == 1 ]; then
      MSE_TMP_INSTALL_INTERFACE_MSG+=("Do you want to install \"myShellEnv\" login message?")
      MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_CONTRAST}It will be seen by all users!${MSE_TMP_INSTALL_COLOR_NONE}")
      mse_install_promptUser

      MSE_TMP_INSTALL_OPTIONS_LOGIN_MESSAGE=${MSE_TMP_INSTALL_PROMPT_RESULT}
    fi
  fi





  if [ $ISOK == 1 ]; then

    #
    # Verifica se deve instalar mesmo para este usuário
    MSE_TMP_INSTALL_INTERFACE_MSG+=("Confirm installation for this user")
    mse_install_promptUser

    MSE_TMP_INSTALL_OPTIONS_CURRENT_USER=${MSE_TMP_INSTALL_PROMPT_RESULT}

    #
    # Instala no local indicado
    if [ $MSE_TMP_INSTALL_OPTIONS_GLOBAL == 1 ] || [ $MSE_TMP_INSTALL_OPTIONS_CURRENT_USER == 1 ]; then
      mse_install_myShellEnv

      #
      # Se a instalação principal ocorreu globalmente
      # e, além desta instalação é necessário instalar para o usuário corrente...
      if [ $ISOK == 1 ] && [ $MSE_TMP_INSTALL_OPTIONS_GLOBAL == 1 ] && [ $MSE_TMP_INSTALL_OPTIONS_CURRENT_USER == 1 ]; then
        mseTmpGlobalInstallationPath="${MSE_TMP_INSTALL_PATH_TO_HOME}"
        mseTmpGlobalBashrcBackup="${MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP}"


        MSE_TMP_INSTALLATION_PATH="${MSE_TMP_INSTALL_PATH_TO_HOME}"
        MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP="${MSE_TMP_INSTALLATION_PATH}/.myShellEnv/src/bashrcBackup/bashrc-mse-backup-$(date +%Y-%m-%d-%H-%M-%S)"
        mse_install_myShellEnv "1"

        #
        # Havendo uma falha, remove a instalação global.
        if [ $ISOK == 0 ]; then
          MSE_TMP_INSTALLATION_PATH="${mseTmpGlobalInstallationPath}"
          MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP="${mseTmpGlobalBashrcBackup}"
          mse_remove_failedInstallation
        fi
      fi
    else
      ISOK=0
    fi
  fi
fi





#
# Encerra o script de instalação
if [ $ISOK == 0 ]; then
  MSE_TMP_INSTALL_INTERFACE_MSG+=("Aborted installation\n")
  mse_install_alertUser
else
  MSE_TMP_INSTALL_INTERFACE_MSG+=("${MSE_TMP_INSTALL_COLOR_HIGHLIGHT}Installation success!${MSE_TMP_INSTALL_COLOR_NONE}")

  if [ $MSE_TMP_INSTALL_OPTIONS_GLOBAL == 1 ]; then
    MSE_TMP_INSTALL_INTERFACE_MSG+=("New users will be created with their own installation of \"myShellEnv\"")
  fi
  if [ $MSE_TMP_INSTALL_OPTIONS_CURRENT_USER == 1 ]; then
    MSE_TMP_INSTALL_INTERFACE_MSG+=("To immediately start \"myShellEnv\" use the command:")
    MSE_TMP_INSTALL_INTERFACE_MSG+=(". ~/.bashrc")
  fi

  mse_install_alertUser
fi



unset ISOK
unset MSE_TMP_INSTALL_INDENT
unset MSE_TMP_INSTALL_INTERFACE_MSG
unset MSE_TMP_INSTALL_PROMPT_RESULT

unset MSE_TMP_INSTALL_COLOR_NONE
unset MSE_TMP_INSTALL_COLOR_HIGHLIGHT
unset MSE_TMP_INSTALL_COLOR_CONTRAST
unset MSE_TMP_INSTALL_COLOR_ERROR

unset MSE_TMP_INSTALL_OPTIONS_GLOBAL
unset MSE_TMP_INSTALL_OPTIONS_CURRENT_USER
unset MSE_TMP_INSTALL_OPTIONS_LOGIN_MESSAGE

unset MSE_TMP_INSTALLATION_PATH
unset MSE_TMP_INSTALL_PATH_TO_HOME
unset MSE_TMP_INSTALL_PATH_TO_BASHRC_BACKUP


unset mse_install_alertUser
unset mse_install_promptUser
unset mse_install_checkIfCommandExists
unset mse_install_myShellEnv
