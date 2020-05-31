SELECT
  h.event "Wait Event",
  SUM(h.wait_time + h.time_waited) "Total Wait Time"
FROM
  v$active_session_history h,
  v$event_name e
WHERE h.sample_time BETWEEN sysdate - 1/24 AND sysdate
  AND h.event_id = e.event_id
  AND e.wait_class <> 'Idle'
GROUP BY h.event
ORDER BY 2 DESC;
