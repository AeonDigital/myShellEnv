#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e



#
# Prompt padrão caso os scripts não sejam carregados
PS1='\[\e[49;00;37m\]\$ \[\e[49;01;30m\]\u\[\e[49;00;37m\]@\[\e[49;01;30m\]\h \[\e[49;00;37m\]:\[\e[49;00;37m\]\040'



source ~/myShellEnv/config.sh || true



#
# Apenas se está carregando o 'myShellEnv' e
# está em uma sessão que iniciou por um login,
# apresenta a mensagem de entrada.
#
if [ $MSE_GB_ENABLE == 1 ] && [ $MSE_GB_START == 1 ] && [ "$0" == "-bash" ]; then

  #
  # Coleta informações do sistema
  mseKERNEL=`uname -r`
  mseARCH=`uname -m`
  mseCPU=`awk -F '[ :][ :]+' '/^model name/ { print $2; exit; }' /proc/cpuinfo`

  mseMEMORY1=`free -t -m | grep "Mem" | awk '{print $6" MB";}'`
  mseMEMORY2=`free -t -m | grep "Mem" | awk '{print $2" MB";}'`
  mseMEMPERCENT=`free | awk '/Mem/{printf("%.2f% (Used) "), $3/$2*100}'`

  mseDETECTDISK=`mount -v | fgrep 'on / ' | sed -n 's_^\(/dev/[^ ]*\) .*$_\1_p'`
  mseDISC=`df -h | grep $mseDETECTDISK | awk '{print $5 }'`

  mseUP=`uptime -p`
  #msePACMAN=`checkupdates | wc -l`   Pacman: \e[1;34m$msePACMAN packages can be updated\e[00m\e[1;30m
  mseHOSTNAME=`uname -n`

  mseNOW=$(date +"%Y-%m-%d %T")


  clear
  echo -e "\e[37m  Arch Linux $mseKERNEL $mseARCH \e[00m
  \e[1;30m
           #####
          #######
           #####\e[00m                  CPU: \e[1;34m$mseCPU\e[00m
                               Memory: \e[1;34m$mseMEMORY1 / $mseMEMORY2 - $mseMEMPERCENT\e[00m\e[1;30m
   #####   #####\e[00m             Use Disk: \e[1;34m$mseDISC (used)\e[00m\e[1;30m
  ####### #######\e[00m              Uptime: \e[1;34m$mseUP\e[00m\e[1;30m
   #####   #####

   #####           #####\e[00m         User: \e[1;34m$USER\e[00m\e[1;30m
  #######         #######\e[00m        Host: \e[1;34m$mseHOSTNAME\e[00m\e[1;30m
   #####           #####\e[00m         Date: \e[1;34m$mseNOW\e[00m

  "


  unset mseKERNEL
  unset mseARCH
  unset mseCPU
  unset mseMEMORY1
  unset mseMEMORY2
  unset mseMEMPERCENT
  unset mseDETECTDISK
  unset mseDISC
  unset mseUP
  unset msePACMAN
  unset mseHOSTNAME
  unset mseNOW
fi
