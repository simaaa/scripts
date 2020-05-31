-- https://oracle-base.com/articles/10g/dbms_service
--TAB=CONFIG
select t.* from v$parameter t where t.name like '%service%';
--TAB=SESSION
select sys_context('userenv','service_name') as service_name_userenv, t.service_name, t.* from v$session t where t.username is not null;
--TAB=SERVICES
select * from V$SERVICES;
--TAB=ACTIVE_SERVICES
select * from V$ACTIVE_SERVICES;

/*
ALTER SYSTEM SET service_names="<original_value>, teszt";
ALTER SYSTEM SET service_names="orcl.local, teszt";
ALTER SYSTEM SET service_names="orcl, teszt";
ALTER SYSTEM RESET service_names;
*/
