SELECT
  p.pdb_id, p.pdb_name
  ,u.username, u.account_status, u.common
  --,u.default_tablespace, u.temporary_tablespace
  ,u.last_login, u.proxy_only_connect
  ,u.created, u.lock_date, u.expiry_date
  --,u.authentication_type, u.password_versions, u.password_change_date
  --,u.*
FROM dba_pdbs p, cdb_users u
WHERE p.pdb_id = u.con_id AND p.pdb_id > 2
AND u.account_status = 'OPEN'
--AND u.username like '%%'
ORDER BY u.username, p.pdb_name;

/*
CREATE USER c##dba1 IDENTIFIED BY aa;
GRANT CREATE SESSION, DBA TO c##dba1 CONTAINER=ALL;
*/
-- ALTER USER c##my_user ADD CONTAINER_DATA=(PDB$SEED) CONTAINER=CURRENT;
-- ALTER USER c##my_user REMOVE CONTAINER_DATA=(PDB$SEED) CONTAINER=CURRENT;
-- ALTER USER c##my_user SET CONTAINER_DATA=DEFAULT CONTAINER=CURRENT;
-- ALTER USER c##my_user SET CONTAINER_DATA=ALL CONTAINER=CURRENT;
