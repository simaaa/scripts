-- https://oracle-base.com/articles/12c/multitenant-application-containers-12cr2
SELECT
  c.name,
  aps.con_uid,
  aps.app_name,
  aps.app_version,
  aps.app_status
FROM dba_app_pdb_status aps, v$containers c
WHERE c.con_uid = aps.con_uid
--AND aps.app_name = 'REF_APP'
ORDER BY c.name;
