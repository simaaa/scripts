cat /dev/null > $ORACLE_BASE/diag/$ORACLE_SID/$ORACLE_SID/trace/alert_$ORACLE_SID.log

TRIM
tail -50000 /path/to/alert_ORCL.log > /path/to/alert_ORCL.log.copy
cp -f /path/to/alert_ORCL.log.copy /path/to/alert_ORCL.log
cat /dev/null > /path/to/alert_ORCL.log.copy
