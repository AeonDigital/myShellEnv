#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e
clear
#timedatectl set-timezone America/Sao_Paulo



#
# Prompt padrão
PS1="\[\e[40;00;37m\]\$ \[\e[40;01;30m\]\u\[\e[40;00;37m\]@\[\e[40;01;30m\]\h : \[\e[40;00;37m\]"
MYSHELLENV_START=0



#
# Data e hora
NOW=$(date +"%Y-%m-%d %T")
NOWD=$(date +"%Y-%m-%d")
NOWT=$(date +"%T")



#
# Configuração do bash
HISTCONTROL=ignoreboth
HISTSIZE=256
HISTTIMEFORMAT="%d/%m/%y %T "





#
# Se $USER está definido...
if [ "$USER" != "" ]; then
  MYSHELLENV_START=1

  for tgtFile in ~/myShellEnv/functions/interface/*; do
    source "${tgtFile}" || true
  done



  #
  # Dá a chance de usuários 'root' optarem por
  # carregar ou não o 'myShellEnv'.
  #
  if [ "$EUID" == 0 ]; then
    setIMessage "${SILVER}Deseja iniciar o myShellEnv?${NONE}" 1

    promptUser
    MYSHELLENV_START=${PROMPT_RESULT}
    PROMPT_RESULT=""
  fi
fi





#
# Conforme processamento anterior
# carrega o restante dos scripts
#
if [ "$MYSHELLENV_START" == 1 ]; then
  BASE_DIR="~/myShellEnv/"
  DIR_SCRIPTS=("*" "string/*" "terminal/*" "thirdPart/*" "prompts/*")

  for tgtdir in "${DIR_SCRIPTS[@]}"; do
    TMP="${BASE_DIR}${tgtdir}"

    for tgtFile in "${TMP}"; do
      source "$tgtFile" || true
    done
  done


  #PS1=$PSTYLE03D
fi





#
# Apenas se está carregando o 'myShellEnv'
# e está em uma sessão que iniciou por um login
# apresenta a mensagem de entrada.
#
if [ "$MYSHELLENV_START" == 1 ] && [ "$0" == "-bash" ]; then
  clear


  #
  # Informações do sistema
  KERNEL=`uname -r`
  ARCH=`uname -m`
  CPU=`awk -F '[ :][ :]+' '/^model name/ { print $2; exit; }' /proc/cpuinfo`

  MEMORY1=`free -t -m | grep "Mem" | awk '{print $6" MB";}'`
  MEMORY2=`free -t -m | grep "Mem" | awk '{print $2" MB";}'`
  MEMPERCENT=`free | awk '/Mem/{printf("%.2f% (Used) "), $3/$2*100}'`

  DETECTDISK=`mount -v | fgrep 'on / ' | sed -n 's_^\(/dev/[^ ]*\) .*$_\1_p'`
  DISC=`df -h | grep $DETECTDISK | awk '{print $5 }'`

  UP=`uptime -p`
  PACMAN=`checkupdates | wc -l 2>/dev/null`
  HOSTNAME=`uname -n`



  echo -e "\e[37m  Arch Linux $KERNEL $ARCH \e[00m
  \e[1;30m
           #####
          #######
           #####\e[00m                  CPU: \e[1;34m$CPU\e[00m
                               Memory: \e[1;34m$MEMORY1 / $MEMORY2 - $MEMPERCENT\e[00m\e[1;30m
   #####   #####\e[00m             Use Disk: \e[1;34m$DISC (used)\e[00m\e[1;30m
  ####### #######\e[00m              Uptime: \e[1;34m$UP\e[00m\e[1;30m
   #####   #####\e[00m               Pacman: \e[1;34m$PACMAN packages can be updated\e[00m\e[1;30m

   #####           #####\e[00m         User: \e[1;34m$USER\e[00m\e[1;30m
  #######         #######\e[00m        Host: \e[1;34m$HOSTNAME\e[00m\e[1;30m
   #####           #####\e[00m         Date: \e[1;34m$NOW\e[00m

  "
fi
