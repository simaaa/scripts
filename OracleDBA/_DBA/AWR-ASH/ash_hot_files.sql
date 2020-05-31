SELECT
  f.file_name        "Data File",
  COUNT(*)           "Wait Number",
  SUM(h.time_waited) "Total Time Waited"
FROM
  v$active_session_history h,
  dba_data_files           f
WHERE
  h.current_file# = f.file_id
GROUP BY f.file_name
ORDER BY 3 DESC;
