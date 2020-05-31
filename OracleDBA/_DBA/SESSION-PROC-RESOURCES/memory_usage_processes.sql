SELECT
  t.pid, t.spid, t.pname, t.username, t.terminal, t.program,
  t.pga_used_mem, ROUND(t.pga_used_mem/1024/1024,2) AS "pga_used_mem (MB)",
  t.pga_alloc_mem, ROUND(t.pga_alloc_mem/1024/1024,2) AS "pga_alloc_mem (MB)"
FROM v$process t WHERE 1=1
AND t.pga_used_mem > 3*(1024*1024) -- Greather than 3 MB
--AND spid = 19983
ORDER BY pga_used_mem DESC
