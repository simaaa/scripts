select
  s.sid, s.serial#, p.spid, s.server,
  s.status, s.username, s.schemaname, s.osuser, s.terminal, s.machine,
  s.program, s.module, s.action
  --,s.*
  --,p.*
from v$session s
left join v$process p on s.paddr = p.addr
where 1=1
and s.username is not null
and s.username != 'DBSNMP' and s.program != 'OMS'
and s.osuser != 'developer' and s.program not like '%Park%' and s.program not like '%Penz%' and s.program not like '%peresit%' and s.program not like '%BmOnSrv%'
--and s.server != 'DEDICATED'
--and s.status = 'ACTIVE'
