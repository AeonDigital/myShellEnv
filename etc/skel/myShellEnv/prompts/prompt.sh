#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
## $ rianna@archlinux : _
PRINTSTYLE01="${NONE}$ username@host : "
PSTYLE01="\[\e[40;00;37m\]\$ \u@\h : "


## $ rianna@archlinux : _
PRINTSTYLE02A="${NONE}${GREEN}\$ username@host : ${NONE}"
PSTYLE02A="\[\e[40;00;32m\]\$ \u@\h : \[\e[40;00;37m\]"


## $ rianna@archlinux : _
PRINTSTYLE02B="${NONE}${CYAN}\$ ${GREEN}username@host ${CYAN}: ${NONE}"
PSTYLE02B="\[\e[40;00;36m\]\$ \[\e[40;00;32m\]\u@\h \[\e[40;00;36m\]: \[\e[40;00;37m\]"


## $ rianna@archlinux : _
PRINTSTYLE02C="${NONE}${CYAN}\$ ${GREEN}username${WHITE}@${GREEN}host ${CYAN}: ${NONE}"
PSTYLE02C="\[\e[40;00;36m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;00;36m\] : \[\e[40;00;37m\]"


# $ rianna@archlinux in ~/DirName/SubDir
# > _
PRINTSTYLE03A="${NONE}${LBLUE}\$ ${GREEN}username${WHITE}@${GREEN}host ${LBLUE}in ${CYAN}~/atual/directory/path \n${CYAN}> ${NONE}"
PSTYLE03A="\[\e[40;01;34m\]\$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\076 \[\e[40;00;37m\]"


# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─╼ _
PRINTSTYLE03B="${NONE}${CYAN}\342\224\214\342\224\200\342\224\200${LBLUE} \$ ${GREEN}username${WHITE}@${GREEN}host ${LBLUE}in ${CYAN}~/atual/directory/path \n${CYAN}\342\224\224\342\224\200\342\225\274 ${NONE}"
PSTYLE03B="\[\e[40;00;36m\]\342\224\214\342\224\200\342\224\200\[\e[40;01;34m\] \$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;00;36m\]\342\224\224\342\225\274 \[\e[40;00;37m\]"


# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─> _
PRINTSTYLE03C="${NONE}${CYAN}\342\224\214\342\224\200\342\224\200${LBLUE} \$ ${GREEN}username${WHITE}@${GREEN}host ${LBLUE}in ${CYAN}~/atual/directory/path \n${CYAN}\342\224\224\342\224\200\076 ${NONE}"
PSTYLE03C="\[\e[40;00;36m\]\342\224\214\342\224\200\342\224\200\[\e[40;01;34m\] \$ \[\e[40;00;32m\]\u\[\e[40;00;37m\]@\[\e[40;00;32m\]\h\[\e[40;01;34m\] in \[\e[40;00;36m\]\w \n\[\e[40;00;36m\]\342\224\224\342\224\200\076 \[\e[40;00;37m\]"


# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─> _
PRINTSTYLE03D="${NONE}${DGREY}\342\224\214\342\224\200\342\224\200${LBLUE} \$ ${WHITE}username${DGREY}@${WHITE}host${LBLUE} in ${DGREY}~/atual/directory/path \n${DGREY}\342\224\224\342\224\200\076 ${NONE}"
PSTYLE03D="\[\e[40;01;30m\]\342\224\214\342\224\200\342\224\200\[\e[40;01;34m\] \$ \[\e[40;00;37m\]\u\[\e[40;01;30m\]@\[\e[40;00;37m\]\h\[\e[40;01;34m\] in \[\e[40;01;30m\]\w \n\[\e[40;01;30m\]\342\224\224\342\224\200\076 \[\e[40;00;37m\]"
