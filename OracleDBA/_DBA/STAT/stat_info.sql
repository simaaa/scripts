--TAB=CONFIG
SELECT
  DBMS_STATS.get_stats_history_retention,
  DBMS_STATS.get_stats_history_availability,
  'EXEC DBMS_STATS.alter_stats_history_retention(31);' AS CHANGE_RETENTION
FROM dual;

--TAB=USAGE
SELECT  occupant_name "Item",
    space_usage_kbytes/1024 "Space Used (MB)",
    space_usage_kbytes/1024/1024 "Space Used (GB)",
    schema_name "Schema",
    move_procedure "Move Procedure"
FROM v$sysaux_occupants
ORDER BY 2 desc;
