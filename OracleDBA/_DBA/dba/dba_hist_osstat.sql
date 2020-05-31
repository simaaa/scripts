select
  'OS Busy Time' series, --to_char(snaptime, 'yyyy.mm.dd   hh24:mi:Ss') snap_time,
  to_char(begin_interval_time, 'yyyy.mm.dd   hh24:mi:Ss') as begin_interval,
  to_char(end_interval_time, 'yyyy.mm.dd   hh24:mi:Ss') end_interval,
  round(busydelta / (busydelta + idledelta) * 100, 2) "CPU Use (%)"
from (
  select
    s.begin_interval_time, s.end_interval_time,
    s.begin_interval_time snaptime,
    os1.value - lag(os1.value) over (order by s.snap_id) busydelta,
    os2.value - lag(os2.value) over (order by s.snap_id) idledelta
  from dba_hist_snapshot s, dba_hist_osstat os1, dba_hist_osstat os2
  where s.snap_id = os1.snap_id and s.snap_id = os2.snap_id
  and s.instance_number = os1.instance_number and s.instance_number = os2.instance_number
  and s.dbid = os1.dbid and s.dbid = os2.dbid
  and s.instance_number = (select instance_number from v$instance)
  and s.dbid = (select dbid from v$database)
  and os1.stat_name = 'BUSY_TIME'
  and os2.stat_name = 'IDLE_TIME'
  --and s.snap_id between &beginsnap and &endsnap
)
order by begin_interval desc
