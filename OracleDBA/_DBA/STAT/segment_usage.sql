SELECT
  t.owner, t.segment_type, t.segment_name, SUM(t.bytes/1024/1024) MB,
  CASE segment_type
    WHEN 'TABLE' THEN 'alter table ' || t.owner || '.' || t.segment_name || ' move tablespace SYSAUX;'
    WHEN 'INDEX' THEN 'alter index ' || t.owner || '.' || t.segment_name || ' rebuild /*online*/ parallel (degree 14);'
    WHEN 'TABLE PARTITION' THEN 'alter table ' || t.owner || '.' || t.segment_name || ' move partition XXX tablespace sysaux;'
    WHEN 'INDEX PARTITION' THEN 'alter index ' || t.owner || '.' || t.segment_name || ' rebuild partition XXX tablespace sysaux;'
  END AS REORG_DDL,
  CASE segment_type WHEN 'TABLE' THEN 'SELECT count(1) FROM ' || t.segment_name || ';' ELSE NULL END AS TABLE_REC_COUNT
FROM dba_segments t
WHERE 1=1
--AND t.owner = 'SYSMAN'
AND t.tablespace_name = 'SYSAUX'
AND ( t.segment_type in ('TABLE','INDEX')
  OR t.segment_type in ('TABLE PARTITION','INDEX PARTITION')
--  OR t.segment_type LIKE '%LOB%'
)
--AND t.segment_name like 'WRI$_OPTSTAT%'
GROUP BY t.owner, t.segment_type, t.segment_name
HAVING SUM(t.bytes/1024/1024) > 4
ORDER BY SUM(t.bytes) DESC;

