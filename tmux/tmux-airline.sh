#!/bin/sh

LSEP=
LSEPE=
RSEP=
RSEPE=

CLOCK=◴
CALENDAR=◰
MEMORY=⬓
USER=

WIDTH=${1}

SMALL=80
MEDIUM=140

if [ "$WIDTH" -gt "$MEDIUM" ]; then
  MEMUSED="$(free -h | egrep 'Mem: .*' | tr -s ' ' | cut -d ' ' -f 3)"
  MEMTOTAL="$(free -h | egrep 'Mem: .*' | tr -s ' ' | cut -d ' ' -f 2)"
  MEM="#[fg=colour252,bg=default,nobold,noitalics,nounderscore]$RSEP#[fg=colour16,bg=colour252,noitalics,nounderscore] $MEMORY $MEMUSED / $MEMTOTAL"
  date_colour='colour252'
fi

if [ "$WIDTH" -ge "$SMALL" ]; then
  UNAME="#[fg=colour252,bg=colour236,nobold,noitalics,nounderscore]$RSEP#[fg=colour16,bg=colour252,noitalics,nounderscore] $USER $(whoami)@$(uname -n)"
fi
DATE="#[fg=colour236,bg=${date_colour:-default},nobold,noitalics,nounderscore]$RSEP#[fg=colour247,bg=colour236,nobold,noitalics,nounderscore] $CALENDAR $(date +'%D')"
TIME="#[fg=colour241,bg=colour236,nobold,noitalics,nounderscore]$RSEPE#[fg=colour252,bg=colour236,noitalics,nounderscore] $CLOCK $(date +'%H:%M')"

echo "$MEM $DATE $TIME $UNAME " | sed 's/ *$/ /g'
