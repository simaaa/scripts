@Echo Off
sqlplus -s sys/sysmanager2020@DEV as sysdba @db_check_dump.pdc > db_check_dump.log
SET SQL_RESULT=%ERRORLEVEL%
ECHO RESULT=%SQL_RESULT%
PAUSE
