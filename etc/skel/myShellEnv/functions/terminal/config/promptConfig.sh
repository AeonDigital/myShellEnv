#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Armazena o nome do estilo que está sendo usado neste momento.
MSE_PROMPT_SELECTED_STYLE=NEWLINE01
MSE_PROMPT_SELECTED_STYLE_INDEX=1


#
# Armazena a coleção de cores definidas para cada um dos possíveis placeholders
#
# Para cada placeholder, a configuração de cores deve ser armazenada numa única string
# onde cada item é separada por um espaço e respeitando a seguinte ordem:
#
#   @example
#     [PLACEHOLDER]="FONTE FUNDO ATRIBUTO"
#     [SYMBOLS]="LGREY NONE DEFAULT"
#
declare -A MSE_PROMPT_SELECTED_COLORS
MSE_PROMPT_SELECTED_COLORS[SYMBOLS]="LBLUE NONE DEFAULT"
MSE_PROMPT_SELECTED_COLORS[USERNAME]="DGREY NONE DEFAULT"
MSE_PROMPT_SELECTED_COLORS[DIRECTORY]="DGREY NONE DEFAULT"
