#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Atualiza a instalação do 'myShellEnv' para o usuário que está
# logado neste momento
#
updateMyShellEnv() {
  TMP="${HOME}/installMyShellEnvTmp.sh"
  URL="${URL_INSTALL}functions/mseManager/installMyShellEnv.sh"
  SCODE=$(curl -s -w "%{http_code}" -o "${TMP}" "${URL}" || true)

  if [ ! -f "$TMP" ] || [ $SCODE != 200 ]; then
    ISOK=0

    printf "    Não foi possível fazer o download do arquivo de atualizações \n"
    printf "    A instalação foi encerrada.\n"
    printf "    TGT: ${TMP} \n"
    printf "    URL: ${URL} \n\n"
  else
    printf "    > Carregando script: ${TMP} \n"

    TMPOLD='installMyShellEnv()'
    TMPNEW='installMyShellEnvTmp()'
    sed -i "s/$TMPOLD/$TMPNEW/g" $TMP

    chmod u+x $TMP
    source $TMP
    installMyShellEnvTmp 0
  fi
}
