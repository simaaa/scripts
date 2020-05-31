select t.* from dba_role_privs t where 1=1
--and t.grantee like '%%'
--and t.granted_role like '%%'
order by 1, 2
