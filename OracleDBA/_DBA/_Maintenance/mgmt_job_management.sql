select t.*, t.rowid from mgmt_job_schedule t where 1=1
--and t.schedule_id like '%6E5D525073AAD603E050030AD0010763%'
order by 1;

select t.*, t.rowid from mgmt_job t where 1=1
--and t.job_owner like '%SYS%'
--and t.job_name like '%BACKUP%'
order by t.job_name;

-- EXEC SYSMAN.MGMT_JOB_ENGINE.delete_job( p_job_name => '6E5D525073ABD603E050030AD0010763', p_job_owner => 'SYS', p_commit => TRUE );
-- EXEC SYSMAN.MGMT_JOB_ENGINE.stop_all_executions_with_id( p_job_id => '6E5D525073ABD603E050030AD0010763', p_force_stop => TRUE );
