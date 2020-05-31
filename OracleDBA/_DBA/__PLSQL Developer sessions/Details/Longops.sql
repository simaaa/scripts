select
  ROUND(sl.elapsed_seconds/60) || ':' || MOD(sl.elapsed_seconds,60) elapsed,
  ROUND(sl.time_remaining/60) || ':' || MOD(sl.time_remaining,60) remaining,
  ROUND(sl.sofar/sl.totalwork*100, 2) progress_pct
  ,sl.*
from v$session_longops sl
where sl.sid = :sid
and sl.serial# = :serial#
order by remaining desc, elapsed desc;
