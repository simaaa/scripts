SELECT
  Block_Size, File_name, currsize_Mb, currsize_Gb, smallest_Mb, smallest_Gb,
  'ALTER database datafile ''' || File_name || ''' resize ' || smallest_Mb || ' M;' AS RESIZE_DDL
FROM (
  SELECT
       file_name as File_name,
       ceil( (nvl(hwm,1)*C.VALUE)/1024/1024 ) as smallest_Mb, ceil( (nvl(hwm,1)*C.VALUE)/1024/1024/1024 ) as smallest_Gb,
       ceil( blocks*C.VALUE/1024/1024) as currsize_Mb, ceil( blocks*C.VALUE/1024/1024/1024) as currsize_Gb,
       ceil( blocks*C.VALUE/1024/1024) - ceil( (nvl(hwm,1)*C.VALUE)/1024/1024 ) as Shrink_Mb,
       a.autoextensible as Auto_extend , a.maxbytes/1024/1024 as Extend_max_MB, C.VALUE AS Block_Size
  FROM dba_data_files a,
       (select file_id, max(block_id+blocks-1) hwm from dba_extents group by file_id ) b,
       (select value from v$parameter where name = 'db_block_size') C
  WHERE a.file_id = b.file_id(+) AND a.file_name in (select FILE_NAME from  dba_data_files)
)
WHERE 1=1
;
