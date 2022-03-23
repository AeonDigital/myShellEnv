#!/usr/bin/env bash
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Navegação e comandos de listagem
alias ..="cd .."
alias tohome="cd ~"
alias toroot="cd /"

alias cls="clear;pwd;ls -lsA --group-directories-first"

alias ls="ls --color=auto --group-directories-first"
alias ll="ls --color=auto --group-directories-first"
alias lall="ls -lsA --group-directories-first"
alias ldir="ls -ld */"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --colour=auto"
alias fgrep="fgrep --colour=auto"
alias egrep="egrep --colour=auto"

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
