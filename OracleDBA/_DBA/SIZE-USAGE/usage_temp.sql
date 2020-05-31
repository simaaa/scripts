--TAB=TEMP
select
  s.username, s.osuser, s.sid, s.serial#, s.program, s.module, s.action,
  tu.session_addr,
  tu.session_num,
  tu.sqladdr,
  tu.sqlhash,
  tu.sql_id,
  tu.contents,
  tu.segtype,
  tu.tablespace,
  tu.extents,
  tu.blocks,
  tbs.block_size,
  tu.blocks * tbs.block_size / 1024 / 1024 as "Used MB",
  round(tu.blocks * tbs.block_size / 1024 / 1024 /1024,2) as "Used GB"
from v$tempseg_usage tu, v$session s, dba_tablespaces tbs
where tu.session_num = s.SERIAL#
and tu.tablespace = tbs.tablespace_name
--and s.sid = :sid
order by tu.username, s.sid, s.module;

--TAB=TEMP SORT
select
  s.username, s.osuser, s.sid, s.serial#, s.program, s.module, s.action,  
  p.spid,
  p.program,
  sum(su.blocks) * tbs.block_size / 1024 / 1024 as "Used MB",
  round(sum(su.blocks) * tbs.block_size / 1024 / 1024 / 1024,2) as "Used GB",
  su.tablespace,
  count(1) GroupByCount
from v$session s, v$sort_usage su, v$process p, dba_tablespaces tbs
where s.saddr = su.session_addr
and s.paddr = p.addr
and su.tablespace = tbs.tablespace_name
--and s.sid = :sid
group by
  s.username,
  s.osuser,
  s.sid,
  s.serial#,
  s.program,
  s.module,
  s.action,
  p.spid,
  p.program,
  tbs.block_size,
  su.tablespace
order by
  sum(su.blocks) * tbs.block_size desc;
