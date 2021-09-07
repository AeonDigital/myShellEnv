#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Inicia uma listagem de todas as fontes que podem ser usadas para o seu terminal.
#
# Tratam-se de fontes que podem ser usadas num terminal sem interface gráfica.
# Você pode selecionar uma fonte em especial usando o comando:
# setfont [nome-da-fonte]
#
#   @tip
#   Use o comando 'showconsolefont' para ver os caracteres da fonte atualmente definida
#   no seu terminal.
#   Conheça os códigos dos caracteres usando o comando 'showkey -a' (Linux) ou o
#   'printCharTable' que vem junto com esta distribuição do 'myShellEnv'.
#
listTerminalFonts() {
  find / -name "*.psf*" | sort | uniq | less
}
