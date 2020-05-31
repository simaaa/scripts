SELECT
  t.sid, s.serial#, s.username, s.osuser, s.program, s.module, s.action,
  SUM(t.value/100) as "cpu usage (seconds)"
FROM v$session s
JOIN v$sesstat t ON s.sid = t.sid
JOIN v$statname n ON t.STATISTIC# = n.STATISTIC#
WHERE s.status='ACTIVE' AND s.username is not null
AND n.name like '%CPU used by this session%'
--AND s.osuser != 'LorinczZ'
GROUP BY t.sid, s.serial#, s.username, s.osuser, s.program, s.module, s.action
HAVING SUM(t.value/100) > 0
