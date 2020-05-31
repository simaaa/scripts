--TAB=DB
select SYS_CONTEXT('USERENV', 'SERVER_HOST') as server_host, t.name, t.created, t.open_mode, t.platform_name, t.flashback_on, t.db_unique_name from v$database t;

--TAB=DB-NLS
select t.* from nls_database_parameters t;

--TAB=PARAMETERS
select t.* from v$parameter t where t.name in ('service_names','shared_servers','processes') or t.name like '%audit%' order by t.name;

--TAB=MEMORY
select round(t.value/1024/1024/1024,2) as gb, t.* from v$parameter t where t.name in ('memory_target','memory_max_target','sga_target','sga_max_size','pga_aggregate_target') order by t.name;

--TAB=SERVICE NAMES
select t.* from v$parameter t where t.name like '%service_names%';

--TAB=SHARED SERVERS
select t.* from v$parameter t where t.name like 'shared_servers';

--TAB=DIRECTORIES
select t.*, 'CREATE OR REPLACE DIRECTORY ' || t.directory_name || ' AS ''' || t.directory_path || ''';' AS CREATE_DDL from dba_directories t order by t.owner, t.directory_name;

--TAB=DBLINK
select t.* from dba_db_links t order by t.owner, t.db_link;

--TAB=CONTEXT
select t.* from dba_context t where t.schema not in ('SYS','SYSMAN','CTXSYS','WMSYS') order by t.namespace;

--TAB=ARCHIVELOG state
select DECODE(t.log_mode,'ARCHIVELOG','ON','OFF') as state, '   ->   ' AS " ", t.log_mode, t.archivelog_change#, t.archivelog_compression from v$database t;

--TAB=ARCHIVELOG
select t.* from v$parameter t
where t.name in ('log_archive_dest', 'log_archive_dest_1', 'log_archive_dest_2', 'log_archive_dest_state_1', 'log_archive_dest_state_2', 'log_archive_format', 'log_archive_start', 'log_archive_trace')
order by t.name;

--TAB=SCHEDULER JOBS
SELECT
  TO_CHAR(next_run_date,'YYYY.MM.DD. HH24:MI:SS') AS next_run_date,
  owner, job_name, comments, program_name, system, enabled, auto_drop, restartable, state,
  job_type, job_action, source, repeat_interval, run_count, retry_count, failure_count,
  TO_CHAR(start_date,'YYYY.MM.DD. HH24:MI:SS') AS start_date,
  TO_CHAR(end_date,'YYYY.MM.DD. HH24:MI:SS') AS end_date,
  TO_CHAR(last_start_date,'YYYY.MM.DD. HH24:MI:SS') AS last_start_date,
  last_run_duration,
  TO_CHAR(next_run_date,'YYYY.MM.DD. HH24:MI:SS') AS next_run_date,
  schedule_limit,
  max_run_duration,
  client_id
FROM dba_scheduler_jobs t WHERE 1=1
AND t.owner not in (
  'ANONYMOUS','APEX_030200','APEX_PUBLIC_USER','APPQOSSYS','CTXSYS','DBSNMP','DIP','EXFSYS','FLOWS_FILES',
  'MDDATA','MDSYS','MGMT_VIEW','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','OWBSYS','OWBSYS_AUDIT',
  'SCOTT','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSMAN','SYSTEM','WMSYS','XDB','XS$NULL'
)
ORDER BY t.owner, t.schedule_name;

--TAB=XDB PORTS
select DBMS_XDB.getHTTPPort, DBMS_XDB.getFTPPort from dual;

--TAB=USERS
SELECT username, 'DROP USER ' || username || ' CASCADE;' AS DROP_DDL FROM dba_users WHERE 1=1
AND username NOT IN (
  'ANONYMOUS','APEX_030200','APEX_PUBLIC_USER','APPQOSSYS','CTXSYS','DBSNMP','DIP','DMSYS','EXFSYS','FLOWS_FILES',
  'LBACSYS','MDDATA','MDSYS','MGMT_VIEW','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','OWBSYS','OWBSYS_AUDIT',
  'SCOTT','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSMAN','SYSTEM','TSMSYS','WMSYS','XDB','XS$NULL'
)
ORDER BY username;
