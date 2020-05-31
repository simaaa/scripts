select pu.* from proxy_users pu where 1=1
--and pu.proxy = '%LorinczZ%'
order by pu.proxy, pu.client
;

select p.* from dba_proxies p where 1=1
--and p.proxy like upper('%LorinczZ%')
order by p.proxy, p.client
;

/*
ALTER USER park REVOKE CONNECT THROUGH moszab;
ALTER USER park GRANT CONNECT THROUGH moszab;
*/
