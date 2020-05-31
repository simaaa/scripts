SELECT
  j.job_owner,  j.job_type, j.job_name, --j.job_id, t.target_name, t.target_type, t.target_guid,
  --e.execution_id,  e.start_time, e.end_time,
  DECODE( status,
          1, 'Scheduled',
          2, 'Running',
          3, 'Error',
          4, 'Failed',
          5, 'Succeeded',
          6, 'Suspended By User',
          7, 'Suspended: Agent Unreacheable',
          8, 'Stopped',
          9, 'Suspended on Lock',
         10, 'Suspended on Event',
         11, 'Stop Pending',
         13, 'Suspend Pending',
         14, 'Inactive',
         15, 'Queued',
         16, 'Failed Retried',
         17, 'Suspended',
         18, 'Skipped', status) status,
  e.scheduled_time,
  DECODE(s.frequency_code, 1, 'One Time', 2, 'Interval', 3, 'Daily', 4, 'Weekly', 5, 'Monthy', 6, 'Yearly') schedule_type,
  s.interval/*,
  DECODE(s.timezone_info, 3, to_char(s.timezone_offset), s.timezone_region) timezone_region,
  DECODE(s.timezone_info, 1, 'Repository', 2, 'Agent', 3, 'Specified Offset/Region', 4, 'Specified Offset/Region', s.timezone_info) timezone_type,
  TH.TARGET_NAME host_name, TP.PROPERTY_VALUE IP_address*/
FROM
  sysman.MGMT_JOB j,
  sysman.MGMT_JOB_SCHEDULE s,
  sysman.MGMT_JOB_EXEC_SUMMARY e,
  sysman.MGMT_JOB_TARGET jt,
  sysman.MGMT_TARGETS t,
  sysman.MGMT_TARGET_ASSOCS ta,
  sysman.MGMT_TARGETS th,
  sysman.MGMT_TARGET_PROPERTIES tp
WHERE j.schedule_id        = s.schedule_id
AND j.IS_LIBRARY           = 0
AND j.system_job           = 0
AND j.nested               = 0
AND j.is_corrective_action = 0
AND j.job_id               = e.job_id
AND e.job_id               = jt.job_id (+)
AND e.execution_id         = jt.execution_id (+)
AND jt.target_guid         = t.target_guid (+)
AND jt.target_guid         = ta.SOURCE_TARGET_GUID
AND ta.ASSOC_TARGET_GUID   = th.TARGET_GUID
AND th.TARGET_TYPE         = 'host'
AND ta.ASSOC_TARGET_GUID   = tp.TARGET_GUID
AND tp.PROPERTY_NAME       = 'IP_address'
--
-- you can modify the following parameters
--
AND Job_name like '%BACKUP%'
--AND status = 1 -- Scheduled
--AND scheduled_time between to_date('2012-10-27 16:00','yyyy-mm-dd hh24:mi') and to_date('2012-10-28 10:00','yyyy-mm-dd hh24:mi')
ORDER BY j.job_owner, j.job_name, e.scheduled_time;
