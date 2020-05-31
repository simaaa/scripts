SELECT p.spid, p.pid, s.sid, s.serial#, s.status, p.pga_alloc_mem, p.pga_used_mem, s.username, s.osuser, s.program
FROM v$process p, v$session s
WHERE p.addr = s.paddr(+)
AND p.background IS NULL      -- remove if need to monitor background processes
ORDER BY p.pga_alloc_mem DESC;
