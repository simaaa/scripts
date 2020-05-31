select t.group#, l.status, t.member, l.next_time
from v$logfile t
join v$log l on t.group# = l.group#
order by t.group#, t.member;

/*
-- DROPPING
alter database drop logfile member '/opt/rdolog/orcl/redo01.log';
alter database drop logfile member '/opt/rdolog/orcl/redo02.log';
alter database drop logfile member '/opt/rdolog/orcl/redo03.log';

alter database drop logfile member '/opt/rdolog/ORCL/redo01.log';
alter database drop logfile member '/opt/rdolog/ORCL/redo02.log';
alter database drop logfile member '/opt/rdolog/ORCL/redo03.log';

alter database drop logfile member '/rdolog/orcl/onlinelog/redo01.log';
alter database drop logfile member '/rdolog/orcl/onlinelog/redo02.log';
alter database drop logfile member '/rdolog/orcl/onlinelog/redo03.log';


-- ADDING
ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/orcl/redolog_nfs/redo01.log' TO GROUP 1;
ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/orcl/redolog_nfs/redo02.log' TO GROUP 2;
ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/orcl/redolog_nfs/redo03.log' TO GROUP 3;

ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/ORCL/redolog_nfs/redo01.log' TO GROUP 1;
ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/ORCL/redolog_nfs/redo02.log' TO GROUP 2;
ALTER DATABASE ADD LOGFILE MEMBER '/u02/oradata/ORCL/redolog_nfs/redo03.log' TO GROUP 3;
*/

