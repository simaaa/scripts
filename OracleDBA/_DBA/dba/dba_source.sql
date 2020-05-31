select t.* from dba_source t where 1=1
--and t.owner like upper('%%')
--and upper(t.text) like '%%' 
order by t.owner, t.name, t.line
