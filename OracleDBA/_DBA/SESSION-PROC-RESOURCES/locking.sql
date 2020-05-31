select
  o.owner,
  o.object_name,
  o.subobject_name,
  o.object_type,
  s.sid,
  s.serial#,
  s.status,
  s.osuser,
  s.machine,
  l.type,  -- Type or system/user lock
  l.lmode, -- lock mode in which session holds lock
  l.request,
  l.block,
  l.ctime  -- Time since current mode was granted
from
  v$locked_object lo, v$session s, dba_objects o, v$lock l
where lo.session_id = s.sid
  and lo.object_id  = o.object_id
  and o.object_id   = l.id1
  and lo.session_id = l.sid
order by o.owner, o.object_name, o.subobject_name, l.ctime desc
;
