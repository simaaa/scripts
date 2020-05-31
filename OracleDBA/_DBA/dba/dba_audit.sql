--select t.* from sys.aud$ t;
select t.* from v$parameter t where t.name like '%audit%';
select t.* from dba_stmt_audit_opts t order by t.audit_option;
select t.* from dba_priv_audit_opts t order by t.privilege;
select t.* from dba_audit_policies t;
select t.* from dba_audit_policy_columns t;

select t.action_name, t.* from dba_audit_trail t;
--/* PERFORMANCE */ select t.action_name, t.* from dba_audit_trail t order by t.timestamp desc;
--/* ONLY LOGON, LOGOFF */ select t.action_name, t.* from dba_audit_trail t where t.action in (100,101) order by t.timestamp desc;
--/* WITHOUT LOGON, LOGOFF */ select t.action_name, t.* from dba_audit_trail t where t.action not in (100,101) order by t.timestamp desc;

/* OTHERS
select t.* from dba_audit_exists t;
select t.* from dba_audit_object t;
select t.* from dba_audit_session t;
select t.* from dba_audit_statement t;
*/
