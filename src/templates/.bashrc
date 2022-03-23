# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# [[INI-MYSHELLENV]]
# Do not remove the markup above and below to
# 'myshellenv' to manage your custom bashrc.
if [ -f ~/.myShellEnv/src/init.sh ]; then
  . ~/.myShellEnv/src/init.sh || true
fi
# Add your customizations in the lines below
# [[END-MYSHELLENV]]
