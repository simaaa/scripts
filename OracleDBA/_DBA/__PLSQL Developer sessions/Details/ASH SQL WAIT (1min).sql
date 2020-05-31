SELECT
  MAX(ash.sample_time) AS sample_time_max, a.module, a.action, a.sql_text, e.name,
  COUNT(*),
  SUM(ash.time_waited), SUM(a.BUFFER_GETS), SUM(a.DISK_READS), SUM(a.DIRECT_WRITES)
FROM  v$active_session_history ash, v$event_name e, v$sqlarea a
WHERE ash.event# = e.event#
AND ash.sql_id = a.sql_id
AND ash.session_id = :sid
AND ash.sample_time > SYSDATE - 1/(24*60) -- 1 mins
GROUP BY a.module, a.action, a.sql_text, e.name
ORDER BY sample_time_max DESC;
