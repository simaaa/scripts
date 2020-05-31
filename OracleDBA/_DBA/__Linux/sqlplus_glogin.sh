# vi $ORACLE_HOME/sqlplus/admin/glogin.sql
# set sqlprompt "_USER'@'_CONNECT_IDENTIFIER _PRIVILEGE> "

echo "set sqlprompt \"_USER'@'_CONNECT_IDENTIFIER _PRIVILEGE> \"" >> $ORACLE_HOME/sqlplus/admin/glogin.sql
