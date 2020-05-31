select t.* from dba_users t where 1=1
--and upper(t.username) like UPPER('%%')
order by t.username;
