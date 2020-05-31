select * from dba_network_acls;
select * from dba_network_acl_privileges;

/* SETTING ACL Priveleges:
EXEC DBMS_NETWORK_ACL_ADMIN.create_acl( acl => 'utlpkg.xml', description => 'Normal Access', principal => '<ORACLE_USER>', is_grant => TRUE, privilege => 'connect', start_date => null, end_date => null );
  VAGY EXEC DBMS_NETWORK_ACL_ADMIN.add_privilege( acl => 'utlpkg.xml', principal => '<ORACLE_USER>', is_grant => TRUE, privilege => 'connect', start_date => null, end_date => null );
EXEC DBMS_NETWORK_ACL_ADMIN.assign_acl( acl => 'utlpkg.xml', host => '*', lower_port => 20, upper_port => 600 );
*/
-- REMOVE ACL Privs: EXEC DBMS_NETWORK_ACL_ADMIN.DROP_ACL( acl => 'utlpkg.xml' );
