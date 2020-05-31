-- Tab=SESSION WAITS BY EVENT
SELECT sw.event, COUNT(*) FROM v$session_wait sw WHERE sw.wait_class != 'Idle' GROUP BY sw.event ORDER BY 1;

-- Tab=WAITING SESSIONS
SELECT NVL(s.username, '(oracle)') AS username,
       s.sid,
       s.serial#,
       sw.event,
       sw.wait_class,
       sw.wait_time,
       sw.seconds_in_wait,
       sw.state
FROM   v$session_wait sw,
       v$session s
WHERE  s.sid = sw.sid
AND sw.wait_class != 'Idle'
--AND s.username IS NOT NULL AND s.username NOT IN ('DBSNMP')
ORDER BY sw.seconds_in_wait DESC;
