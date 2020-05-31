--TAB=SQL WORKAREA
SELECT
  to_number(decode(sid, 65535, NULL, sid)) sid,
  operation_type                OPERATION,
  TRUNC(WORK_AREA_SIZE/1024)    WORK_AREA_SIZE,
  TRUNC(EXPECTED_SIZE/1024)     EXPECTED_SIZE,
  TRUNC(ACTUAL_MEM_USED/1024)   ACTUAL_MEM_USED,
  TRUNC(MAX_MEM_USED/1024)      "MAX MAX_MEM_USED",
  number_passes                 NUMBER_PASSES
FROM v$sql_workarea_active
ORDER BY 1,2;

--TAB=SESSION RAM USAGE
SELECT
   s.sid, s.serial#, s.username, s.status,
   uga.uga_memory, pga.pga_memory, workarea.workarea_memory, sorts.sort_memory, redos.redo_read_memory
FROM v$session s,
( SELECT y.SID, TO_CHAR(ROUND(y.value/1024/1024),99999999) || ' MB' UGA_MEMORY
  FROM v$sesstat y, v$statname z
  WHERE y.STATISTIC# = z.STATISTIC# AND name = 'session uga memory'
) uga,
( SELECT y.SID, TO_CHAR(ROUND(y.value/1024/1024),99999999) || ' MB' PGA_MEMORY
  FROM v$sesstat y, v$statname z
  WHERE y.STATISTIC# = z.STATISTIC# AND name = 'session pga memory'
) pga,
( SELECT y.SID, TO_CHAR(ROUND(y.value/1024/1024),99999999) || ' MB' WORKAREA_MEMORY
  FROM v$sesstat y, v$statname z
  WHERE y.STATISTIC# = z.STATISTIC# AND name = 'workarea memory allocated'
) workarea,
( SELECT y.SID, TO_CHAR(ROUND(y.value/1024/1024),99999999) || ' MB' SORT_MEMORY
  FROM v$sesstat y, v$statname z
  WHERE y.STATISTIC# = z.STATISTIC# AND name = 'sorts (memory)'
) sorts,
( SELECT y.SID, TO_CHAR(ROUND(y.value/1024/1024),99999999) || ' MB' REDO_READ_MEMORY
  FROM v$sesstat y, v$statname z
  WHERE y.STATISTIC# = z.STATISTIC# AND name = 'redo KB read (memory) for transport'
) redos
WHERE s.sid = uga.sid AND s.sid = pga.sid AND s.sid = workarea.sid AND s.sid = sorts.sid AND s.sid = redos.sid(+)
AND s.username IS NOT NULL
ORDER BY s.status, uga.uga_memory DESC;
