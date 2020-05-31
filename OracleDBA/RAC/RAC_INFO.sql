SELECT inst_id, instance_name, host_name, startup_time, status, archiver, logins, shutdown_pending, database_status, instance_role, active_state, blocked FROM gv$instance ORDER BY inst_id;
SELECT inst_id, name, db_unique_name, log_mode, flashback_on, current_scn, con_id, open_mode, cdb FROM gv$database ORDER BY inst_id;
SELECT name, inst_id, type, value, display_value, isdefault, description, con_id
FROM gv$parameter
WHERE name LIKE '%db_recovery%' OR name = 'db_flashback_retention_target'
OR name = 'log_archive_dest_1' OR name = 'log_archive_format'
OR name = 'db_securefile'
OR name LIKE 'recyc%'
ORDER BY name, inst_id;

SELECT
  FILE_TYPE "Type",
  PERCENT_SPACE_USED "% Used",
  PERCENT_SPACE_RECLAIMABLE "% Reclaim",
  NUMBER_OF_FILES "# Files"
FROM
  V$FLASH_RECOVERY_AREA_USAGE;

SELECT group_number, disk_number, mount_status, mode_status, state, redundancy, name, failgroup, path, voting_file, failgroup_type, con_id
FROM v$asm_disk
--WHERE group_number = (select GROUP_NUMBER from v$asm_diskgroup where NAME='DATA');
ORDER BY group_number, disk_number, name;

SELECT
  SUBSTR(name,1,10) AS name,
  state,
  voting_files,
  offline_disks
  total_mb, ROUND(total_mb/1024,2) AS total_gb,
  free_mb, ROUND(free_mb/1024,2) AS free_gb,
  ROUND(free_mb/total_mb*100,2) AS used_pct,
  cold_used_mb, ROUND(cold_used_mb/1024,2) AS cold_used_gb,
  con_id
FROM
  v$asm_diskgroup
ORDER BY
  name;
