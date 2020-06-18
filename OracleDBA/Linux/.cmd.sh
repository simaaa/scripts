#!/bin/bash

#. dbmenu.sh

if [ -z "$1" ]; then
  echo Not found command parameter!
  exit;
fi

# sqlplus
if [ "$1" == "sql" ]; then
  sqlplus / as sysdba
fi

# rman
if [ "$1" == "rman" ]; then
  rman target / nocatalog
fi

# Checkpoint
if [ "$1" == "chk" ]; then
sqlplus -silent / as sysdba <<EOF
  alter system checkpoint;
  alter system flush buffer_cache;
EOF
fi

# Swtich logfile
if [ "$1" == "sw" ]; then
sqlplus -silent / as sysdba <<EOF
  alter system switch logfile;
EOF
fi

# Query sid list
if [ "$1" == "sid_list" ]; then
  OLDIFS=$IFS
  IFS=:
  grep -v '^\(#\|$\)' /etc/oratab |\
  while read ORASID ORAHOME AUTOSTART; do
    if [ "$AUTOSTART" == "Y" ]; then
      echo $ORASID, $ORAHOME, $AUTOSTART
    fi
  done
  IFS=$OLDIFS
fi

#echo The \'$1\' command not found!
