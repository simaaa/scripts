--TAB=PARAMETERS
select t.* from v$parameter t where t.name like '%flashback%' or t.name like '%db_recovery%' order by t.name;
--TAB=CONFIGURATION
select t.name, t.log_mode, t.flashback_on from v$database t;
--TAB=TABLESPACES
select flashback_on, t.* from v$tablespace t order by t.name;
--TAB=FLASHBACK_ARCHIVE
select flashback_archive_name, status from dba_flashback_archive;
--TAB=FLASHBACK_FILES
select round(t.bytes/1024/1024,2) as "Size(MB)", round(t.bytes/1024/1024/1024,2) as "Size(GB)", t.* from v$flashback_database_logfile t order by t.first_time desc;

/*
ALTER DATABASE FLASHBACK OFF;
ALTER DATABASE FLASHBACK ON;
ALTER SYSTEM SET DB_FLASHBACK_RETENTION_TARGET=1440; -- 1 day (default)
*/
