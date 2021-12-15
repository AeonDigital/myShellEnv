#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Variáveis
MSE_GB_TARGET_FILES=()
ISOK=1



#
# Efetua o download e a instalação dos scripts alvos conforme as
# informações passadas pelos parametros.
# Os scripts alvo desta ação devem estar definidos no array ${MSE_GB_TARGET_FILES}.
#
#   @param string $1
#   URL do local (diretório) onde estão os scripts a serem baixados.
#
#   @param string $2
#   Endereço completo até o diretório onde os scripts serão salvos.
#
#   @example
#     MSE_GB_TARGET_FILES=("script01.sh" "script02.sh" "script03.sh")
#     downloadMyShellEnvFiles "https://myrepo/dir" "${HOME}/myShellEnv/"
#
#   @result
#     O resultado do sucesso ou falha da instalação dos scripts alvos
#     será armazenado na variável ${ISOK} onde '1' significa sucesso
#     e '0' significa falha em algum ponto do processo.
#
downloadMyShellEnvFiles() {
  if [ $# != 2 ]; then
    ISOK=0
    errorAlert "${FUNCNAME[0]}" "expected 2 arguments"
  else
    if [ ${#MSE_GB_TARGET_FILES[@]} == 0 ]; then
      ISOK=0
      errorAlert "${FUNCNAME[0]}" "empty array ${LGREEN}MSE_GB_TARGET_FILES${NONE}"
    else
      mkdir -p "$2"

      if [ ! -d "$2" ]; then
        ISOK=0
        errorAlert "${FUNCNAME[0]}" "target directory $2 cannot be created"
      else
        ISOK=1

        setIMessage "" 1
        setIMessage "Baixando arquivos para o diretório:"
        setIMessage "${LBLUE}$2${NONE} ..."
        alertUser

        local mseScript
        local mseTMP
        for mseScript in "${MSE_GB_TARGET_FILES[@]}"; do
          if [ $ISOK == 1 ]; then
            printf "${MSE_GB_ALERT_INDENT} ... ${LBLUE}${mseScript}${NONE} "
            mseTMP="${2}${mseScript}"
            local mseSCode=$(curl -s -w "%{http_code}" -o "$mseTMP" "${1}${mseScript}" || true)

            if [ ! -f "$mseTMP" ] || [ $mseSCode != 200 ]; then
              ISOK=0
              printf " ${LRED}[x]${NONE}\n"
            else
              printf " ${LGREEN}[v]${NONE}\n"
            fi
          fi
        done


        setIMessage "" 1
        if [ $ISOK == 1 ]; then
          setIMessage "Finalizado com sucesso."
        else
          setIMessage "Processo abortado."
        fi
        alertUser
      fi
    fi
  fi
}
