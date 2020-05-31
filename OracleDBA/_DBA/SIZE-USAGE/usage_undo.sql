--TAB=UNDO
SELECT
  p.spid, s.sid, s.serial#, s.username, s.status, s.osuser, s.machine, s.program, s.module, s.action,
  l.addr as lock_addr,
  r.name "RB Segment Name", dba_seg.size_mb, dba_seg.size_gb,
  s.logon_time, DECODE(TRUNC(SYSDATE - logon_time), 0, NULL, TRUNC(SYSDATE - logon_time) || ' Days' || ' + ') || TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-logon_time,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON
FROM
  v$session s, v$lock l, v$rollname r, v$process p,
  ( SELECT segment_name, ROUND(bytes/(1024*1024),2) size_mb, ROUND(bytes/(1024*1024*1024),2) size_gb
    FROM dba_segments
    WHERE segment_type = 'TYPE2 UNDO'
    ORDER BY bytes DESC
  ) dba_seg
WHERE s.sid = l.sid
AND TRUNC (l.id1(+)/65536) = r.usn
AND l.type(+) = 'TX'
AND l.lmode(+) = 6
AND r.name = dba_seg.segment_name
AND s.paddr = p.addr(+)
--AND s.sid = :sid
ORDER BY size_mb DESC;

--TAB=UNDO TR
select
  --p.spid, s.sid, s.serial#, s.username, s.status, s.osuser, s.machine, s.program, s.module, s.action,
  t.addr tr_addr, t.status tr_status, t.start_date, t.start_time start_time,
  t.used_ublk "Undo blocks",
  t.used_urec "Undo records",
  r.name "RBS name",
  s.logon_time, DECODE(TRUNC(SYSDATE - logon_time), 0, NULL, TRUNC(SYSDATE - logon_time) || ' Days' || ' + ') || TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-logon_time,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON
from v$session s, v$transaction t, v$rollname r, v$process p
where s.saddr = t.ses_addr
and t.xidusn = r.usn
and s.paddr = p.addr(+)
--and s.sid = :sid
order by t.used_ublk desc;

--TAB=UNDO SUM
select
  s.sid, s.serial#, s.username, s.status,
  u.segment_name,
  count(u.extent_id) "Extent Count",
  t.used_ublk "Undo blocks",
  t.used_urec "Undo records",
  s.program
from v$session s, v$transaction t, dba_undo_extents u
where s.taddr = t.addr
and u.segment_name like '_SYSSMU'||t.xidusn||'_%$'
and u.status = 'ACTIVE'
group by
  s.sid,
  s.serial#,
  s.username,
  s.status,
  u.segment_name,
  t.used_ublk,
  t.used_urec,
  s.program
order by
  t.used_ublk desc,
  t.used_urec desc,
  s.sid, s.serial#, s.username, s.program;

--TAB=UNDO STAT
select
  u.tablespace_name, status, extent_count,
  sum_bytes, undo_size,
  round(sum_bytes/1024/1024, 0) as MB,
  round(sum_bytes/1024/1024/1024, 2) as GB,
  round((sum_bytes / undo_size) * 100, 0) as PERC
from (
  select u.tablespace_name, u.status, sum(u.bytes) sum_bytes, count(1) as extent_count
  from dba_undo_extents u
  group by u.tablespace_name, u.status
) u,
(
  select c.tablespace_name, sum(a.bytes) undo_size
  from dba_tablespaces c
    join v$tablespace b on b.name = c.tablespace_name
    join v$datafile a on a.ts# = b.ts#
  where c.contents = 'UNDO' and c.status = 'ONLINE'
  group by c.tablespace_name
) t
where u.tablespace_name = t.tablespace_name
order by u.tablespace_name, u.status;
