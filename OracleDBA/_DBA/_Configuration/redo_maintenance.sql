select t.* from v$log t order by t.group#;
select
  --t.*, l.*
  t.group#, t.type, l.archived, l.status, t.member, l.first_time, l.next_time
  ,'' AS DDL_REMOVE
from v$logfile t
join v$log l on t.group# = l.group#
order by t.group#, t.member;

/*
ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/orcl/redolog_nfs/redo01.log' TO GROUP 1;
ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/orcl/redolog_nfs/redo02.log' TO GROUP 2;
ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/orcl/redolog_nfs/redo03.log' TO GROUP 3;
*/
