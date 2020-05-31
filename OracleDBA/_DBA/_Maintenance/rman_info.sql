select * from v$backup_set/* where input_file_scan_only = 'NO'*/;
select * from v$backup_set_details;
select * from v$backup_datafile;
select * from v$rman_configuration;
select * from v$rman_status order by recid desc;
select * from v$rman_backup_job_details order by start_time desc;
select * from v$rman_backup_subjob_details where status = 'FAILED';
select * from v$rman_output;
select
  j.session_recid, j.session_stamp,
  to_char(j.start_time, 'yyyy-mm-dd hh24:mi:ss') start_time,
  to_char(j.end_time, 'yyyy-mm-dd hh24:mi:ss') end_time,
  (j.output_bytes/1024/1024) output_mbytes, j.status, j.input_type,
  decode(to_char(j.start_time, 'd'), 1, 'Sunday', 2, 'Monday',
                                     3, 'Tuesday', 4, 'Wednesday',
                                     5, 'Thursday', 6, 'Friday',
                                     7, 'Saturday') day,
  j.elapsed_seconds, j.time_taken_display,
  x.cf, x.df, x.i0, x.i1, x.l,
  ro.output_lines output_lines
from V$RMAN_BACKUP_JOB_DETAILS j
left outer join (
  select
    d.session_recid, d.session_stamp,
    sum(case when d.controlfile_included = 'YES' then d.pieces else 0 end) CF,
    sum(case when d.controlfile_included = 'NO'
              and d.backup_type||d.incremental_level = 'D' then d.pieces else 0 end) DF,
    sum(case when d.backup_type||d.incremental_level = 'D0' then d.pieces else 0 end) I0,
    sum(case when d.backup_type||d.incremental_level = 'I1' then d.pieces else 0 end) I1,
    sum(case when d.backup_type = 'L' then d.pieces else 0 end) L
  from V$BACKUP_SET_DETAILS d
  join V$BACKUP_SET s on s.set_stamp = d.set_stamp and s.set_count = d.set_count
  where s.input_file_scan_only = 'NO'
  group by d.session_recid, d.session_stamp
) x on x.session_recid = j.session_recid and x.session_stamp = j.session_stamp
left outer join (
  select o.session_recid, o.session_stamp, count(1) as output_lines
  from v$rman_output o
  group by o.session_recid, o.session_stamp
) ro on ro.session_recid = j.session_recid and ro.session_stamp = j.session_stamp
where 1=1
and j.start_time > trunc(sysdate)-&NUMBER_OF_DAYS
order by j.start_time;
