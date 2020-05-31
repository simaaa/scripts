select t.* from dba_dependencies t where 1=1
and t.type in ('TABLE','VIEW','SYNONYM')
--and t.referenced_owner = ''
--and t.referenced_name like '%%'
--and t.name like '%%'
