select t.* from dba_rsrc_capability t;
select t.* from dba_rsrc_categories t order by t.name;
select t.* from dba_rsrc_consumer_groups t order by t.consumer_group;
select t.* from dba_rsrc_consumer_group_privs t /*where t.granted_group like '%DW_LOAD%'*/ order by t.granted_group, t.grantee;
select t.* from dba_rsrc_group_mappings t /*where t.consumer_group like '%DW_LOAD%'*/ order by t.attribute, t.value, t.consumer_group;
--select t.* from dba_rsrc_instance_capability t;
select t.* from dba_rsrc_io_calibrate t;
select t.* from dba_rsrc_manager_system_privs t;
select t.* from dba_rsrc_mapping_priority t order by t.priority;
select t.* from dba_rsrc_plan_directives t /*where t.plan like '%DW_LOAD%'*/ order by t.plan, t.group_or_subplan, t.type;
select t.* from dba_rsrc_plans t order by t.num_plan_directives;
select t.* from dba_rsrc_storage_pool_mapping t order by t.pool_name, t.attribute;

SELECT
  s.sid, g.name consumer_group, s.state, s.consumed_cpu_time cpu_time, s.cpu_wait_time, s.queued_time,(s.CURRENT_SMALL_READ_MEGABYTES+s.CURRENT_LARGE_READ_MEGABYTES) read_MB,(s.CURRENT_SMALL_WRITE_MEGABYTES+s.CURRENT_LARGE_WRITE_MEGABYTES) write_mb
FROM v$rsrc_session_info s, v$rsrc_consumer_group g
WHERE s.current_consumer_group_id = g.id;
