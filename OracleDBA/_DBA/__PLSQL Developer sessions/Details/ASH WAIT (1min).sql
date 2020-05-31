SELECT NVL(a.event, 'ON CPU') AS event,
       COUNT(*) AS total_wait_time
FROM   v$active_session_history a
WHERE  a.sample_time > SYSDATE - 1/(24*60) -- 1 mins
AND a.SESSION_ID = :sid and a.SESSION_SERIAL# = :serial#
GROUP BY a.event
ORDER BY total_wait_time DESC;
