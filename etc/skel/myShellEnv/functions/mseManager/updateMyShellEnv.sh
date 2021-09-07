#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Atualiza a instalação do 'myShellEnv' para o usuário que está
# logado neste momento
#
updateMyShellEnv() {
  local mseTMP="${HOME}/installMyShellEnvTmp.sh"
  local mseURL="${MSE_GB_URL_INSTALL}functions/mseManager/installMyShellEnv.sh"
  local mseSCode=$(curl -s -w "%{http_code}" -o "${mseTMP}" "${mseURL}" || true)

  if [ ! -f "$mseTMP" ] || [ $mseSCode != 200 ]; then
    ISOK=0

    printf "    Não foi possível fazer o download do arquivo de atualizações \n"
    printf "    A instalação foi encerrada.\n"
    printf "    TGT: ${mseTMP} \n"
    printf "    URL: ${mseURL} \n\n"
  else
    ISOK=1
    printf "    > Carregando script: ${mseTMP} \n"

    local mseOLD='installMyShellEnv()'
    local mseNEW='installMyShellEnvTmp()'
    sed -i "s/$mseOLD/$mseNEW/g" $mseTMP

    chmod u+x $mseTMP
    source $mseTMP
    installMyShellEnvTmp 'u'
    #rm "${HOME}/installMyShellEnvTmp.sh"


    #
    # Falhando o processo de atualização..
    if [ $ISOK == 0 ]; then
      # remove os arquivos temporários
      if [ -d "${HOME}/myShellEnvUpdate/" ]; then
        rm -r "${HOME}/myShellEnvUpdate/"
      fi
    else
      # substitui o diretório antigo pelo novo.
      rm -r "${HOME}/myShellEnv/"
      mv "${HOME}/myShellEnvUpdate/" "${HOME}/myShellEnv/"
    fi
  fi
}
