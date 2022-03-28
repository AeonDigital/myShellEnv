# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# [[INI-MYSHELLENV]]
# Do not remove the markup above and below to
# 'myshellenv' to manage your custom bashrc.
if [ -f ~/.myShellEnv/src/init.sh ]; then
  . ~/.myShellEnv/src/init.sh || true

  # load personal configuration of myShellEnv if exists
  if [ -f ~/.myShellEnvConf.sh ]; then
    .  ~/.myShellEnvConf.sh || true
  fi
  PS1=$(mse_term_retrieveRawPromptCode 1)


  shopt -s checkwinsize
  shopt -s histappend

  HISTSIZE=1000
  HISTFILESIZE=2000


  if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi
else
  PS1="\[\e[0;94;49m\]\$ \[\e[0;90;49m\]\u\[\e[0;94;49m\]@\[\e[0;90;49m\]\h\[\e[0;94;49m\] in \[\e[0;37;37m\]\[\e[0;90;49m\]\w \n\076\[\e[0;37;37m\]\040"
fi
# Add your customizations in the lines below
# [[END-MYSHELLENV]]
