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
    "functions/string"
    "functions/tools"
    "management/config_files"
  )

  local mseCountTests=0
  local mseCountAssert=0
  local testISOK=1
  local testError=0


  # Importante!!!
  # sem isto as conversões de caracteres falham
  # Este 'set' funciona na maior parte dos sistemas testados até o momento.
  LC_CTYPE=C


  #
  # Para cada diretório de scripts a ser usado
  for mseTgtDir in "${mseDirScripts[@]}"; do
    local mseTMPDIR=${mseBaseDir}${mseTgtDir}

    if [ ! -d "$mseTMPDIR" ]; then
      testError=1
      echo "Diretório inválido: $mseTMPDIR"
    else
      if [ ! -d "$mseTMPDIR/test" ]; then
        testError=1
        echo "Diretório de testes inexistente: $mseTMPDIR/test"
      else
        echo "#"
        echo "# Diretório: $mseTMPDIR"

        #
        # Identifica os arquivos de script (sh) do diretório principal
        # e os arquivos de teste correspondentes
        local mseFiles=$(find "$mseTMPDIR" -name "*.sh")
        local mseTestFiles=$(find "$mseTMPDIR/test" -name "*.sh")


        if [ "$mseFiles" == "" ]; then
          echo "Diretório vazio: $mseTMPDIR"
        elif [ "$mseTestFiles" == "" ]; then
          echo "Diretório de testes vazio: $mseTMPDIR/test"
        else

          #
          # Carrega os arquivos de scripts e testes
          while read rawLine
          do
            source "$rawLine"
          done <<< ${mseFiles}

          while read rawLine
          do
            source "$rawLine"
          done <<< ${mseTestFiles}



          #
          # Executa a função de teste de cada arquivo de teste identificado
          while read rawLine
          do
            if [ "$testISOK" == "1" ]; then
              local mseFullFileName=$(basename -- "$rawLine")
              local mseExtension="${mseFullFileName##*.}"
              local mseFilename="${mseFullFileName%.*}"


              ((mseCountTests=mseCountTests+1))
              MSE_GB_ALERT_MSG=()
              MSE_GB_PROMPT_MSG=()

              echo "#"
              echo "## $mseFilename"
              $mseFilename
            fi
          done <<< ${mseTestFiles}

        fi
      fi
    fi
  done


  if [ $testError == 0 ]; then
    echo "Scripts testados: $mseCountTests"
    echo "Testes executados: $mseCountAssert"
  fi
}
loadTestScripts
