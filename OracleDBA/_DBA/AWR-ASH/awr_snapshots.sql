select
  dbid, instance_number, snap_id, snap_level,
  --to_char(begin_interval_time, 'yyyy.mm.dd. hh24:mi:ss') begin_interval_time,
  --to_char(end_interval_time, 'yyyy.mm.dd. hh24:mi:ss') end_interval_time,
  to_char(end_interval_time, 'yyyy.mm.dd. hh24:mi:ss') snap_time,
  'SELECT output FROM TABLE( DBMS_WORKLOAD_REPOSITORY.AWR_REPORT_HTML('|| dbid ||','|| instance_number ||','|| (snap_id-1) ||','|| snap_id ||') );' AS generate_report_prev,
  'SELECT output FROM TABLE( DBMS_WORKLOAD_REPOSITORY.AWR_REPORT_HTML('|| dbid ||','|| instance_number ||','|| snap_id ||','|| (snap_id+1) ||') );' AS generate_report_next
from dba_hist_snapshot t
--where begin_interval_time between timestamp'2018-12-05 06:00:00' and timestamp'2018-12-05 08:00:00'
order by snap_time desc;
