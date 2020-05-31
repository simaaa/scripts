-- show parameter cpu;
-- https://docs.oracle.com/cd/B28359_01/server.111/b28320/dynviews_2083.htm#REFRN30321
select t.* from v$parameter t where t.name like '%cpu%';

select
   (select max(value) from dba_hist_osstat where stat_name = 'NUM_CPUS')        NUM_CPUS,
   (select max(value) from dba_hist_osstat where stat_name = 'NUM_CPU_CORES')   NUM_CPU_CORES,
   (select max(value) from dba_hist_osstat where stat_name = 'NUM_CPU_SOCKETS') NUM_CPU_SOCKETS
from dual;

select t.* from v$osstat t where 1=1
and t.stat_name in ('NUM_CPUS','NUM_CPU_CORES','NUM_LCPUS','NUM_VCPUS')
order by t.stat_name;
