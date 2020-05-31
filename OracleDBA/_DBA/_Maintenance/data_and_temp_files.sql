--TAB=TEMP_FILES
select t.*, 'CREATE BIGFILE TEMPORARY TABLESPACE ' || t.tablespace_name || ' TEMPFILE ''/u02/oradata/--FILL--/' || t.tablespace_name || '.DBF'' SIZE 32M REUSE AUTOEXTEND ON NEXT 1M;'
from dba_temp_files t where 1=1
and t.tablespace_name not in ('TEMP')
--and t.tablespace_name like '%%'
--and t.file_name like '%%'
order by t.file_name;

--TAB=DATA_FILES
select t.*, 'CREATE BIGFILE TABLESPACE ' || t.tablespace_name || ' DATAFILE ''/u02/oradata/--FILL--/' || t.tablespace_name || '.DBF'' SIZE 32M REUSE AUTOEXTEND ON NEXT 1M;'
from dba_data_files t where 1=1
and t.tablespace_name not in ('SYSAUX','SYSTEM','UNDOTBS1','USERS')
--and t.tablespace_name like '%%'
--and t.file_name like '%%'
order by t.file_name;
