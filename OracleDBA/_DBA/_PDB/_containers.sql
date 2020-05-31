SELECT
  t.con_id,
  t.dbid,
  t.name,
  t.open_mode,
  t.restricted,
  t.open_time,
  t.recovery_status,
  t.proxy_pdb,
  t.local_undo,
  --t.creation_time,
  t.pdb_count,
  t.member_cdb,
  t.upgrade_level
  --,t.*
FROM v$containers t
ORDER BY t.con_id;
