#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Variáveis
LS_OPTIONS="--group-directories-first --color=auto"
GREP_OPTIONS="--color=auto"

#
# Navegação e comandos de listagem
alias ..="cd .."
alias cd..="cd .."
alias tohome="cd ~"
alias toroot="cd /"

alias ls="ls $LS_OPTIONS"
alias dir="dir $LS_OPTIONS"
alias vdir="vdir $LS_OPTIONS"

alias ll="ls -l"
alias lla="ls -lsA"
alias lld="ls -ld */"

alias cls="clear;pwd;ls -lsAhN"

alias grep="grep $GREP_OPTIONS"
alias fgrep="fgrep $GREP_OPTIONS"
alias egrep="egrep $GREP_OPTIONS"


#
## Procurando arquivos e mostrando informações
alias whereis="find / -name"
alias whereisci="find / -iname"
alias whereisdir="find / -type d -name"
alias whereisdirci="find / -type d -iname"
alias showmyip="curl ipinfo.io/ip"
alias showdate="date +'%A, %d de %B - %Y [%T (%Z)]'"

#
## Redefinindo o bash
alias reloadbash=". ~/.bashrc"
alias restartbash="exec bash"
