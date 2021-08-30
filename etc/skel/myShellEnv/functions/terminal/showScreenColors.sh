#!/bin/bash
# myShellEnv v 1.0 [aeondigital.com.br]
#
set +e





#
# Mostra as cores de tela disponíveis no shell e
# que podem ser utilizadas para a estilização das mensagens
# de interface.
#
showScreenColors() {
  source ~/myShellEnv/functions/thirdPart/print256colours.sh || true
}
