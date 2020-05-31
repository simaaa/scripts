select
  t.elapsed_seconds, round(t.elapsed_seconds/60,2) elapsed_min,
  t.input_type, t.start_time, t.end_time, t.status, --t.output_device_type,
  t.input_bytes_display input_size, t.output_bytes_display output_size,
  t.input_bytes_per_sec_display in_speed_per_sec, t.output_bytes_per_sec_display out_speed_per_sec
  --,t.*
from v$rman_backup_job_details t where 1=1
and t.input_type in ('DB FULL','ARCHIVELOG')
and t.start_time > SYSDATE-30
--and t.start_time between timestamp'2019-01-02 05:00:00' and timestamp'2019-01-02 18:00:00'
order by t.start_time desc;
