#!/bin/bash
export CDPATH=.:~:..:/u/prd/rls/:
export HISTIGNORE="c:ls"
export HISTFILE=/tmp/$LOGNAME.history
export HISTSIZE=150000
export PS1='[\u@\h:\w] >'
export PS1="\u@\h \W/ > "
set -o emacs

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

export CSCOPE_EDITOR=/usr/bin/vim
export PUNITH_HOME=/home/punith
export PATH=$PATH:/usr/local/bin:/sbin/
export PATH=$PATH:$PUNITH_HOME/punith_utils/cscope_tags

# To increase core file size
ulimit -c 100000000
shopt -s cdspell
shopt -s dotglob

umask 022

source $PUNITH_HOME/punith_utils/alias
# Place this in target PCs bashrc
#alias cdp='cd /home/intel-rangeley/punith; source punith_utils/bashrc'
