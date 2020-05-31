select t.* from dba_external_tables t where 1=1
--and t.owner like '%%'
--and t.table_name like upper('%%')
--and upper(t.access_parameters) like upper('%%')
order by t.owner, t.table_name
