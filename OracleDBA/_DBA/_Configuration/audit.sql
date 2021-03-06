--TAB=AUDIT configuration
select t.* from v$parameter t where t.name like '%audit%' order by t.name;

/*
-- https://docs.oracle.com/cd/E11882_01/server.112/e40402/initparams017.htm#REFRN10006
ALTER SYSTEM SET audit_sys_operations=TRUE SCOPE=SPFILE;
ALTER SYSTEM SET audit_trail=NONE SCOPE=SPFILE;
ALTER SYSTEM SET audit_trail=OS SCOPE=SPFILE;
ALTER SYSTEM SET audit_trail=DB,EXTENDED SCOPE=SPFILE;
TRUNCATE TABLE system.aud$;
*/

/*
NOAUDIT ALTER ANY PROCEDURE;
NOAUDIT ALTER ANY TABLE;
NOAUDIT CREATE ANY PROCEDURE;
NOAUDIT CREATE ANY TABLE;
NOAUDIT CREATE SESSION;
NOAUDIT DROP ANY PROCEDURE;
NOAUDIT DROP ANY TABLE;
NOAUDIT GRANT ANY OBJECT PRIVILEGE;
NOAUDIT GRANT ANY PRIVILEGE;
*/
