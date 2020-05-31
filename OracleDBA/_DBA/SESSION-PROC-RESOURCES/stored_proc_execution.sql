SELECT
  o.kglnaown ||'.'|| o.kglnaobj AS stored_object,
  SUM(c.kglhdexc)               AS sql_executions
FROM sys.x$kglob o, sys.x$kglrd d, sys.x$kglcursor c
WHERE o.kglhdadr = d.kglhdcdr
AND d.kglrdhdl = c.kglhdpar
AND o.inst_id = userenv('Instance')
AND d.inst_id = userenv('Instance')
AND c.inst_id = userenv('Instance')
AND o.kglobtyp in (7, 8, 9, 11, 12)
--AND o.kglnaown NOT IN ('SYS','SYSTEM','APEX_190200','DBSNMP','GSMADMIN_INTERNAL')
AND o.kglnaown LIKE '%%'
AND o.kglnaobj LIKE '%%'
GROUP BY o.kglnaown, o.kglnaobj
ORDER BY 2 DESC;
