--TAB=GROUP BY TABLESPACE
select t.tablespace_name, sum(t.bytes)/1024/1024 total_size_mb, round(sum(t.bytes)/1024/1024/1024,2) total_size_gb
from dba_temp_files t
where 1=1
--and t.tablespace_name like '%%'
group by t.tablespace_name
order by t.tablespace_name;

--TAB=FILES
select
  t.tablespace_name,
  t.status,
  round(t.bytes/1024/1024,0) total_size_mb,
  round(t.bytes/1024/1024/1024,2) total_size_gb,
  --t.file_name,
  'ALTER DATABASE TEMPFILE ''' || t.file_name || ''' OFFLINE;' as DDL_OFFLINE,
  'ALTER DATABASE RENAME FILE ''' || t.file_name || ''' TO '' --CHANGE-->' || t.file_name || ''';' AS DDL_MOVE,
  'ALTER DATABASE TEMPFILE ''' || t.file_name || ''' ONLINE;' as DDL_ONLINE
from dba_temp_files t
where 1=1
--and t.tablespace_name like '%%'
order by t.tablespace_name;
