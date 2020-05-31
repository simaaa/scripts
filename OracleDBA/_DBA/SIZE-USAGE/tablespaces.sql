SELECT
  df.tablespace_name "Tablespace",
  totalusedspace "Used MB",
  (df.totalspace - tu.totalusedspace) "Free MB",
  df.totalspace "Total MB",
  ROUND(((df.totalspace - tu.totalusedspace) / df.totalspace)*100) "Pct. Free"
FROM
  (SELECT tablespace_name, round(sum(bytes) / 1048576) TotalSpace FROM dba_data_files GROUP BY tablespace_name) df,
  (SELECT ROUND(SUM(bytes)/(1024*1024)) totalusedspace, tablespace_name FROM dba_segments GROUP BY tablespace_name) tu
WHERE
  df.tablespace_name = tu.tablespace_name
ORDER BY
  df.tablespace_name;
