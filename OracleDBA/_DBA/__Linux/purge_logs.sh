#!/bin/bash
clear

function purge_trace() {
  OBS_IN_MIN=10080 # 7 days
  OBS_IN_MIN=0 # 7 days, pruge all content
  for f in $( adrci exec="show homes" | grep -v "ADR Homes:" ); do
    #echo "Start Purginng $f at $(date)";
    #echo "set homepath $f; show home; purge -age $OBS_IN_MIN; echo 'Purged 100%';";
    adrci exec="set homepath $f; show home; purge -age $OBS_IN_MIN; echo 'Purged 100%';";
  done
}

function purge_listener_log() {
  for f in $( adrci exec="show homes" | grep "tnslsnr" ); do
    if [[ $f == *"tnslsnr"* ]]; then
      lsnrctl set log_status off
      rm $ORACLE_BASE/$f/alert/log.xml
      rm $ORACLE_BASE/$f/trace/listener.log
      lsnrctl set log_status on
    fi;
  done
}

function purge_aud() {
  #find /u01/app/oracle/admin/*/adump -type f -name '*.aud' -mtime +1 -exec rm -f {} \;
  #find /u01/app/oracle/admin/*/adump -type f -name '*.aud' -mtime +1 -delete;
  find /u01/app/oracle/admin/*/adump -type f -name '*.aud' -delete;
}

purge_trace;
purge_listener_log;
purge_aud;
