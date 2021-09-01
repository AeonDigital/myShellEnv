#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Variáveis de configuração do ambiente myShellEnv
#
# Para evitar conflitos entre variáveis de ambientes criadas por outros
# pacotes, scripts ou desenvolvedores toda variável usada neste projeto
# terá o prefixo 'MSE_GB_' (myShellEnv Global).
#
# Variáveis de escopo fechado (como condicionais Ifs e loops For)
# usarão o prefixo 'mse'.
#
# Além disso, toda variável global e temporária terá o prefixo 'TMP'
#




#
# Indica se é ou não para iniciar o 'myShellEnv'
# Caso não seja, nenhuma função ou variável do projeto será carregada.
#
# @type bool
#
MSE_GB_ENABLE=1
if [ $MSE_GB_ENABLE == 1 ]; then

  #
  # Carrega as funções de interface
  for mseTgtFile in ~/myShellEnv/functions/interface/*; do
    source "${mseTgtFile}" || true
  done
  unset mseTgtFile



  #
  # Informa se é para carregar todos os demais scripts ou não.
  #
  # @type bool
  #
  MSE_GB_START=1


  #
  # Identifica se é para iniciar o 'myShellEnv' para usuários 'root'.
  #
  # @type bool
  #
  MSE_GB_ROOT_AUTOSTART=0


  #
  # Identifica se é para oferecer ao usuário 'root' a inicialização do
  # 'myShellEnv'
  #
  # @type bool
  #
  MSE_GB_ROOT_PROMPTSTART=1



  #
  # Verifica se realmente deve iniciar uma sessão completa para o usuário atual
  if [ $MSE_GB_START == 1 ]; then

    #
    # Tratando-se de um usuário 'root' com o 'autostart'
    # desativado
    if [ $EUID == 0 ] && [ $MSE_GB_ROOT_AUTOSTART == 0 ]; then
      MSE_GB_START=0

      #
      # Sendo para questioná-lo sobre o início da sessão...
      if [ $MSE_GB_ROOT_PROMPTSTART == 1 ]; then
        setIMessage "${SILVER}Deseja iniciar o myShellEnv?${NONE}" 1

        promptUser
        MSE_GB_START=${MSE_GB_PROMPT_RESULT}
        MSE_GB_PROMPT_RESULT=""
      fi
    fi
  fi



  #
  # Sendo realmente para ativar uma sessão completa
  # carrega todos os arquivos de scripts do projeto
  if [ $MSE_GB_START == 1 ]; then

    mseBaseDir="${HOME}/myShellEnv/"
    mseDirScripts=(
      "functions/*" "functions/string/*"
      "functions/terminal/*" "functions/thirdPart/*"
      "functions/mseManager/*"
    )

    for mseTgtDir in "${mseDirScripts[@]}"; do
      TMP="${mseBaseDir}${mseTgtDir}"

      for mseTgtFile in $TMP; do
        if [ -f $mseTgtFile ]; then
          source "$mseTgtFile" || true
        fi
      done
    done

    setPromptSelection


    unset mseBaseDir
    unset mseDirScripts
    unset mseTgtDir
    unset mseTgtFile
  fi





  #
  # Prompt padrão caso nenhum outro seja definido
  MSE_GB_PROMPT_STYLE='SIMPLE'
  MSE_GB_PROMPT_COLOR_SYMBOLS='WHITE'
  MSE_GB_PROMPT_COLOR_USERNAME='DGREY'
  MSE_GB_PROMPT_COLOR_DIRECTORY='WHITE'



  #
  # Configuração para o bash
  HISTCONTROL=ignoreboth
  HISTSIZE=256
  HISTTIMEFORMAT="%d/%m/%y %T "


fi
