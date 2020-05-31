SELECT t.owner, t.name, t.type, t.plsql_debug, t.plsql_warnings FROM dba_plsql_object_settings t WHERE 1=1
--AND t.owner LIKE '%%'
--AND t.name LIKE '%%'
AND t.plsql_debug = 'TRUE'
ORDER BY t.owner, t.name, t.type;
