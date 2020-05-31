select t.* from v$parameter t where upper(t.name) like upper('%recyc%');

/*
ALTER SYSTEM SET recyclebin=off DEFERRED; -- RESTART REUIRED
PURGE dba_recyclebin;
-- SHOW PARAMETER recyclebin;
*/
