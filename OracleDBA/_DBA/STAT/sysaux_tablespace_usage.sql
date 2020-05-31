select
  a.tablespace_name,
  sum(a.bytes)/(1024*1024) Allocated,
  sum(a.bytes)/(1024*1024) - max(nvl(b.space,0)) Used,
  max(nvl(b.space,0)) Free,round(((max(nvl(b.space,0)))/(sum(a.bytes)/(1024*1024))),4)*100 perctfree,
  max(nvl(b.cont,0))/(1024*1024)  Contiguous
from
  dba_data_files a,
  ( select tablespace_name,sum(bytes)/(1024*1024) space,max(bytes) cont
    from dba_free_space
    group by tablespace_name
  ) b
where a.tablespace_name = b.tablespace_name(+)
and a.tablespace_name = 'SYSAUX'
group by a.tablespace_name
--order by a.tablespace_name
order by 3 desc
