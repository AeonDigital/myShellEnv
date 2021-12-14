#!/bin/bash -eu
# myShellEnv v 1.0 [aeondigital.com.br]







#
# Variáveis
#
# As variáveis abaixo guardam a configuração atual do prompt.
# Há 2 conjuntos de variáveis que são usadas para tal tarefa.
#
#   - STYLE
#   Armazenam informações referentes ao estilo do prompt que é a forma
#   física como ele é apresentado.
#
#   - PLACEHOLDERS
#   Estes são 'espaços reservados' dentro do estilo selecionado que permite
#   que a informação abrigada no mesmo tenha sua coloração configurada.
#


#
# Definição dos estilos dos prompts
#
MSE_PROMPT_STYLE_NAME=()
MSE_PROMPT_STYLE_SAMPLE=()
MSE_PROMPT_STYLE_SQUEMA=()


#
# Registra todos os placeholders disponíveis para configuração de todos os
# tipos de estilos definidos.
#
# A marcação especial [[NONE]] pode ser usada para encerrar totalmente a estilização
# de uma cadeia de caracteres. Ela faz com que a marcação de texto volte ao padrão
# definido que é com a cor de fonte Cinza claro e fundo preto.
#
MSE_PROMPT_STYLE_PLACEHOLDERS=(
  "SYMBOLS" "USERNAME" "DIRECTORY"
)


#
# Triangular terminator
#
# Char          : 
# Hex code      : E0B0
# Decimal code  : 57520
# Hex UTF-8     : EE 82 B0
# Octal UTF-8   : 356 202 260
#


#
# Estilo simples
# > $ rianna@archlinux : _
MSE_PROMPT_STYLE_NAME[0]="SIMPLE"
MSE_PROMPT_STYLE_SAMPLE[0]="${NONE}$ username@host : _"
MSE_PROMPT_STYLE_SQUEMA[0]='[[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] :[[NONE]]\040'

#
# Estilo 'Nova linha 01'
# $ rianna@archlinux in ~/DirName/SubDir
# > _
MSE_PROMPT_STYLE_NAME[1]="NEWLINE01"
MSE_PROMPT_STYLE_SAMPLE[1]="${NONE}\$ username@host in ~/atual/directory/path \n> _"
MSE_PROMPT_STYLE_SQUEMA[1]='[[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n\076[[NONE]]\040'

#
# Estilo 'Nova linha 02'
# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─> _
MSE_PROMPT_STYLE_NAME[2]="NEWLINE02"
MSE_PROMPT_STYLE_SAMPLE[2]="${NONE}\342\224\214\342\224\200\342\224\200 \$ username@host in ~/atual/directory/path \n\342\224\224\342\224\200\076 _"
MSE_PROMPT_STYLE_SQUEMA[2]='[[DIRECTORY]]\[\342\224\]\214\[\342\224\]\200\[\342\224\]\200 [[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n[[DIRECTORY]]\[\342\224\]\224\[\342\224\]\200\076[[NONE]]\040'

#
# Estilo 'Nova linha 03'
# ┌── $ rianna@archlinux in ~/DirName/SubDir
# └─╼ _
MSE_PROMPT_STYLE_NAME[3]="NEWLINE03"
MSE_PROMPT_STYLE_SAMPLE[3]="${NONE}\342\224\214\342\224\200\342\224\200 \$ username@host in ~/atual/directory/path \n\342\224\224\342\224\200\342\225\274 _"
MSE_PROMPT_STYLE_SQUEMA[3]='[[DIRECTORY]]\[\342\224\]\214\[\342\224\]\200\[\342\224\]\200 [[SYMBOLS]]\$ [[USERNAME]]\u[[SYMBOLS]]@[[USERNAME]]\h[[SYMBOLS]] in [[DIRECTORY]]\w \n[[DIRECTORY]]\[\342\224\]\224\[\342\225\]\274[[NONE]]\040'
