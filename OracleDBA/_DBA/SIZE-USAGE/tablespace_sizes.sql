select
  data_files.tablespace_name                            AS "Tablespace",
  round(data_files.bytes_alloc/1024/1024)               AS "Total Alloc (MB)",
  round(data_files.physical_bytes/1024/1024)            AS "Phys Alloc (MB)",
  round(segm.total_used_mb)                             AS "Used (MB)",
  round(data_files.total_space_mb - segm.total_used_mb) AS "Free (MB)",
  NULL AS "  ",
  round(100 * ( (data_files.total_space_mb - segm.total_used_mb)/ data_files.total_space_mb)) AS "Pct. Free",
  NULL AS "  ",
  round(data_files.bytes_alloc/1024/1024/1024,2)              AS "Total Alloc (GB)",
  round(data_files.physical_bytes/1024/1024/1024,2)           AS "Phys Alloc (GB)",
  round(segm.total_used_gb,2)                                 AS "Used (GB)",
  round((data_files.total_space_gb) - (segm.total_used_gb),2) AS "Free (GB)"
from
(
  select tablespace_name,
         sum(decode(autoextensible,'NO',bytes,'YES',maxbytes)) bytes_alloc,
         sum(bytes) physical_bytes, sum(bytes)/1024/1024 total_space_mb, sum(bytes)/1024/1024/1024 total_space_gb
    from dba_data_files
   group by tablespace_name
) data_files,
(
  select tablespace_name, sum(bytes) total_used, sum(bytes)/1024/1024 total_used_mb, sum(bytes)/1024/1024/1024 total_used_gb
    from dba_segments
   group by tablespace_name
) segm
where data_files.tablespace_name = segm.tablespace_name(+)
--and (data_files.tablespace_name = 'UNDO' or data_files.tablespace_name = 'DEVELOPER_DWH_USR_DAT')
--and data_files.tablespace_name like 'D__CDAT_Y20%'
order by data_files.tablespace_name
