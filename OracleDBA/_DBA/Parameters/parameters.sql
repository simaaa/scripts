SELECT t.* FROM v$parameter t WHERE 1=1
AND t.name LIKE '%%'
--AND t.value LIKE '%%'
ORDER BY t.name;
