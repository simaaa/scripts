select t.* from dba_tables t where 1=1
--and t.owner like upper('%%')
--and t.table_name like upper('%%')
order by t.owner, t.table_name
