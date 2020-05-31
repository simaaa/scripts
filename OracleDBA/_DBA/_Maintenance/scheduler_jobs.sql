--TAB=JOB_RUN_DETAILS
SELECT TO_CHAR(t.log_date,'YYYY.MM.DD. HH24:MI:SS') AS log_date, t.* FROM user_scheduler_job_run_details t WHERE 1=1
--AND t.owner in (select d.schema_name from DUMP_MASTER.DUMP_SCHEMA d)
ORDER BY t.log_id DESC;

--TAB=JOBS
SELECT
  TO_CHAR(next_run_date,'YYYY.MM.DD. HH24:MI:SS') AS next_run_date,
  owner, job_name, comments, program_name, system, enabled, auto_drop, restartable, state,
  job_type, job_action, source, repeat_interval, run_count, retry_count, failure_count,
  TO_CHAR(start_date,'YYYY.MM.DD. HH24:MI:SS') AS start_date,
  TO_CHAR(end_date,'YYYY.MM.DD. HH24:MI:SS') AS end_date,
  TO_CHAR(last_start_date,'YYYY.MM.DD. HH24:MI:SS') AS last_start_date,
  last_run_duration,
  TO_CHAR(next_run_date,'YYYY.MM.DD. HH24:MI:SS') AS next_run_date,
  schedule_limit,
  max_run_duration,
  client_id
FROM dba_scheduler_jobs t WHERE 1=1
--AND t.owner in (select d.schema_name from DUMP_MASTER.DUMP_SCHEMA d)
--AND t.enabled = 'TRUE'
ORDER BY t.owner, t.schedule_name;

--TAB=RUNNING_JOBS
SELECT t.* FROM dba_scheduler_running_jobs t;

--TAB=JOB_LOG
SELECT t.log_id, TO_CHAR(t.log_date,'YYYY.MM.DD. HH24:MI:SS') AS log_date, t.owner, t.job_name, t.job_class, t.operation, t.status, t.additional_info--,t.*
FROM dba_scheduler_job_log t WHERE 1=1
ORDER BY 1 DESC;

/*
exec dbms_scheduler.purge_log;
exec dbms_scheduler.stop_job('JOB_ADAT_ATADAS');
exec dbms_scheduler.set_scheduler_attribute('SCHEDULER_DISABLED','TRUE');
exec dbms_scheduler.set_scheduler_attribute('SCHEDULER_DISABLED','FALSE');
*/
