--TAB=ARCHIVELOG state
select t.log_mode, t.archivelog_change#, t.archivelog_compression from v$database t;
--TAB=ARCHIVELOG configuration
select t.* from v$parameter t where 1=1
--and upper(t.name) like upper('%arch%')
and t.name in (
  'archive_lag_target',
  'log_archive_config',
  'log_archive_dest',
  'log_archive_dest_1',
  'log_archive_dest_2',
  'log_archive_dest_state_1',
  'log_archive_dest_state_2',
  'log_archive_duplex_dest',
  'log_archive_format',
  'log_archive_local_first',
  'log_archive_max_processes',
  'log_archive_min_succeed_dest',
  'log_archive_start',
  'log_archive_trace',
  'standby_archive_dest'
)
order by t.name;

/*
ALTER SYSTEM SET log_archive_dest_1='LOCATION=/rdolog/PARK01/archivelog' SCOPE=BOTH;
ALTER SYSTEM SET log_archive_format='orcl2_%d_%t_%s_%r.dbf' SCOPE=SPFILE;
*/
