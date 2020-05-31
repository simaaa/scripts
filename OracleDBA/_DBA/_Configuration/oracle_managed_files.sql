-- https://docs.oracle.com/en/database/oracle/oracle-database/19/admin/using-oracle-managed-files.html#GUID-9E04D83B-4758-4E7D-B2A7-673B123F3989

SELECT t.* FROM v$parameter t WHERE (
  t.name = 'db_unique_name' OR
  t.name = 'db_create_file_dest' OR
  t.name like 'db_recovery_file_dest%' OR
  t.name like '%db_create_online_log_dest%'
)
ORDER BY t.name;

/*
ALTER SYSTEM SET db_create_file_dest = '/u01/app/oracle/oradata';
ALTER SYSTEM SET db_recovery_file_dest = '/u01/app/oracle/fast_recovery_area';
ALTER SYSTEM SET db_recovery_file_dest_size = 20G;
ALTER SYSTEM SET db_create_online_log_dest_1 = '/u02/oradata'
*/

/*
CREATE DATABASE sample3
EXTENT MANAGEMENT LOCAL
DATAFILE SIZE 400M
SYSAUX DATAFILE SIZE 200M
DEFAULT TEMPORARY TABLESPACE dflt_ts TEMPFILE SIZE 10M
UNDO TABLESPACE undo_ts DATAFILE SIZE 100M;
*/
