select
--  s.sid, s.serial#, p.spid,
--  s.status, s.username, s.osuser, s.machine,
--  s.module, s.program, s.action,
  sw.event,
  sw.wait_class,
  sw.wait_time,
  sw.seconds_in_wait,
  sw.state,
  sw.p1 as file_id,
  sw.p2 as block_id
from v$session_wait sw, v$session s, v$process p
where s.sid = sw.sid and s.paddr = p.addr
and s.sid = :sid
order by sw.seconds_in_wait desc;
