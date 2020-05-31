--TAB=CONFIG
select t.* from v$parameter t where t.name like '%shared_servers%';
--TAB=v$shared_server_monitor
select * from v$shared_server_monitor;
--TAB=MESSAGE QUEUE
select * from v$queue;
--TAB=v$shared_server
select * from v$shared_server;

/*
--ALTER SYSTEM SET SHARED_SERVERS = 1 SCOPE=BOTH;
--ALTER SYSTEM RESET SHARED_SERVERS SCOPE=SPFILE;

--ALTER SYSTEM SET MAX_SHARED_SERVERS = 10 SCOPE=SPFILE;
--ALTER SYSTEM RESET MAX_SHARED_SERVERS SCOPE=SPFILE;
*/
