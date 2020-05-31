--TAB=GROUP BY TABLESPACE
select t.tablespace_name, sum(t.bytes)/1024/1024 total_size_mb, round(sum(t.bytes)/1024/1024/1024,2) total_size_gb
from dba_data_files t
where 1=1
--and t.owner like '%%'
--and t.tablespace_name like '%%'
group by t.tablespace_name
order by t.tablespace_name;

--TAB=FILES
select
  t.tablespace_name,
  t.online_status,
  round(t.bytes/1024/1024,0) total_size_mb,
  round(t.bytes/1024/1024/1024,2) total_size_gb,
  t.file_name
from dba_data_files t
where 1=1
--and t.owner like '%%'
--and t.tablespace_name like '%%'
order by t.tablespace_name;
