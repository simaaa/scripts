--TAB=CONFIG
select t.* from v$parameter t where t.name like '%dispatchers%';
--TAB=v$dispatcher_config
select * from v$dispatcher_config;
--TAB=v$dispatcher_rate
select * from v$dispatcher_rate;
--TAB=v$dispatcher
select * from v$dispatcher;

/*
--ALTER SYSTEM SET DISPATCHERS="(ADDRESS=(PROTOCOL=TCP)(HOST=ol64appliance.local)(PORT=1521))(DISPATCHERS=20)" SCOPE=BOTH;
--ALTER SYSTEM SET DISPATCHERS="(PROTOCOL=TCP)(SERVICE=<SID>XDB)" SCOPE=BOTH;
--ALTER SYSTEM RESET DISPATCHERS SCOPE=SPFILE;

--ALTER SYSTEM REGISTER;
--ALTER SYSTEM SHUTDOWN IMMEDIATE 'D002';
*/
