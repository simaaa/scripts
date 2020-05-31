select
  di.index_name, di.index_type, di.status, di.tablespace_name
  ,'ALTER INDEX ' || di.index_name || ' REBUILD;' REBUILD0
  --,'ALTER INDEX ' || di.index_name || ' REBUILD TABLESPACE SYSAUX;' REBUILD1
  --,'ALTER INDEX ' || di.index_name || ' REBUILD ONLINE PARALLEL (DEGREE 14);' REBUILD2
from dba_indexes di, dba_tables dt
where di.tablespace_name = 'SYSAUX'
and dt.table_name = di.table_name
--and di.table_name like '%OPT%'
and di.status != 'VALID'
order by 1 asc;
