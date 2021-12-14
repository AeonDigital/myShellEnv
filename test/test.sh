#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Carrega e executa a bateria de testes unitários
loadTestScripts() {
  #
  # Carrega todos os scripts que serão testados
  local mseBaseDir="${PWD}/etc/skel/myShellEnv/"
  local mseDirScripts=(
    "functions/interface"
    #"functions/string"
    #"functions/tools"
  )

  local mseCountTests=0
  local mseCountAssert=0
  local testISOK=1


  #
  # Para cada diretório de scripts a ser usado
  for mseTgtDir in "${mseDirScripts[@]}"; do
    local mseTMPDIR=${mseBaseDir}${mseTgtDir}

    if [ ! -d "$mseTMPDIR" ]; then
      echo "Diretório inválido: $mseTMPDIR"
    else
      echo "#"
      echo "# Diretório: $mseTMPDIR"

      #
      # Identifica os arquivos de script (sh) do diretório
      local mseFiles=$(find "$mseTMPDIR" -name "*.sh")
      if [ "$mseFiles" == "" ]; then
        echo "Diretório vazio: $mseTMPDIR"
      else

        #
        # Carrega cada arquivo identificado
        while read rawLine
        do
          source "$rawLine"
        done <<< ${mseFiles}


        #
        # Executa a função de teste de cada arquivo identificado
        while read rawLine
        do
          if [ "$testISOK" == "1" ]; then
            local mseFileName=$(basename -- "$rawLine")
            mseFileName="${mseFileName%.*}"
            local mseTestName="test_$mseFileName"

            #
            # Apenas se existir uma função de teste
            if [ "$(type -t $mseTestName)" == "function" ]; then
              ((mseCountTests=mseCountTests+1))
              MSE_GB_ALERT_MSG=()
              MSE_GB_PROMPT_MSG=()

              echo "#"
              echo "## $mseFileName"
              $mseTestName
            fi
          fi
        done <<< ${mseFiles}
      fi
    fi
  done

  echo "Scripts testados: $mseCountTests"
  echo "Testes executados: $mseCountAssert"
}
loadTestScripts
