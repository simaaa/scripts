select
  t.tablespace_name, t.file_name,
  'ALTER TABLESPACE ' || t.tablespace_name || ' OFFLINE;' as set_offline,
  'ALTER TABLESPACE ' || t.tablespace_name || ' RENAME DATAFILE ''' || t.file_name || ''' TO ''' || t.file_name || ''';' as change_ddl,
  'ALTER TABLESPACE ' || t.tablespace_name || ' ONLINE;' as set_online
from dba_data_files t
where t.file_name like '%UTF99PARK%'
order by t.tablespace_name;
