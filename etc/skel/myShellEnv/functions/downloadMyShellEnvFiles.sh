#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# @variables
TARGET_FILES=()
ISOK=1



#
# Efetua o download e a instalação dos scripts alvos conforme as
# informações passadas pelos parametros.
# Os scripts alvo desta ação devem estar definidos no array ${TARGET_FILES}.
#
#   @param string $1
#   URL do local (diretório) onde estão os scripts a serem baixados.
#
#   @param string $2
#   Endereço completo até o diretório onde os scripts serão salvos.
#
#   @example
#     TARGET_FILES=("script01.sh" "script02.sh" "script03.sh")
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
    if [ ${#TARGET_FILES[@]} == 0 ]; then
      ISOK=0
      errorAlert "${FUNCNAME[0]}" "empty array ${LGREEN}TARGET_FILES${NONE}"
    else
      mkdir -p "$2"

      if [ ! -d "$2" ]; then
        ISOK=0
        errorAlert "${FUNCNAME[0]}" "target directory $2 cannot be created"
      else
        ISOK=1

        printf "\n${ALERT_INDENT}Baixando arquivos para o diretório: \n"
        printf "\n${ALERT_INDENT}${LBLUE}$2${NONE} ...\n"

        for script in "${TARGET_FILES[@]}"; do
          if [ $ISOK == 1 ]; then
            printf "${ALERT_INDENT} ... ${LBLUE}${script}${NONE} "
            TMP="${2}${script}"
            curl -s -w "%{http_code}" -o "$TMP" "${1}${script}" || true

            if [ ! -f "$TMP" ] || [ $http_code != 200 ]; then
              ISOK=0
              printf " ${LRED}[x]${NONE}\n"
            else
              printf " ${LGREEN}[v]${NONE}\n"
            fi
          fi
        done

        if [ $ISOK == 1 ]; then
          printf "${ALERT_INDENT}Finalizado com sucesso.\n"
        else
          printf "${ALERT_INDENT}Processo abortado.\n"
        fi

      fi
    fi
  fi
}
