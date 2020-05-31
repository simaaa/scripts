select
  s.sid, s.username, s.osuser, s.module, s.action, s.status,
  e.event,
  e.total_waits,
  e.total_timeouts,
  e.time_waited,
  e.average_wait,
  s.blocking_session
from v$session_event e, v$session s
where e.sid = s.sid
--and s.sid = 499
order by e.total_waits desc;
