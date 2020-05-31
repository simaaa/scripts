select t.* from dba_objects t where 1=1
--and t.owner like upper('%%')
--and t.object_name like upper('%%')
order by t.owner, t.object_name
