--CREATE OR REPLACE VIEW V_SIZE_TABLASPACES AS
WITH
df AS
 (SELECT tablespace_name, SUM(bytes) bytes, COUNT(*) cnt, DECODE(SUM(DECODE(autoextensible, 'NO', 0, 1)), 0, 'NO', 'YES') autoext
    FROM dba_data_files
   GROUP BY tablespace_name),
tf AS
 (SELECT tablespace_name, SUM(bytes) bytes, COUNT(*) cnt, DECODE(SUM(DECODE(autoextensible, 'NO', 0, 1)), 0, 'NO', 'YES') autoext
    FROM dba_temp_files
   GROUP BY tablespace_name)
SELECT d.tablespace_name,
       NVL(a.bytes / 1024 / 1024, 0) AS "SIZE",
       NVL(a.bytes - NVL(f.bytes, 0), 0) / 1024 / 1024 AS "USED",
       NVL((a.bytes - NVL(f.bytes, 0)) / a.bytes * 100, 0) AS "USED %",
       a.autoext,
       NVL(f.bytes, 0) / 1024 / 1024 AS "FREE",
       d.status,
       a.cnt,
       d.contents,
       d.extent_management,
       d.segment_space_management
  FROM dba_tablespaces d,
       df a,
       (SELECT tablespace_name, SUM(bytes) bytes
          FROM dba_free_space
         GROUP BY tablespace_name) f
 WHERE d.tablespace_name = a.tablespace_name(+)
   AND d.tablespace_name = f.tablespace_name(+)
   AND NOT d.contents = 'UNDO'
   AND NOT (d.extent_management = 'LOCAL' AND d.contents = 'TEMPORARY')
UNION ALL
SELECT d.tablespace_name,
       NVL(a.bytes / 1024 / 1024, 0)  AS "SIZE",
       NVL(t.ub * d.block_size, 0) / 1024 / 1024 AS "USED",
       NVL((t.ub * d.block_size) / a.bytes * 100, 0) AS "USED %",
       a.autoext,
       (NVL(a.bytes, 0) / 1024 / 1024 -
       NVL((t.ub * d.block_size), 0) / 1024 / 1024) AS "FREE",
       d.status,
       a.cnt,
       d.contents,
       d.extent_management,
       d.segment_space_management
  FROM dba_tablespaces d,
       tf a,
       (SELECT ss.tablespace_name, sum(ss.used_blocks) ub
          FROM gv$sort_segment ss
         GROUP BY ss.tablespace_name) t
 WHERE d.tablespace_name = a.tablespace_name(+)
   AND d.tablespace_name = t.tablespace_name(+)
   AND d.extent_management = 'LOCAL'
   AND d.contents = 'TEMPORARY'
UNION ALL
SELECT d.tablespace_name,
       NVL(a.bytes / 1024 / 1024, 0) AS "SIZE",
       NVL(u.bytes, 0) / 1024 / 1024 AS "USED",
       NVL(u.bytes / a.bytes * 100, 0) AS "USED %",
       a.autoext,
       NVL(a.bytes - NVL(u.bytes, 0), 0) / 1024 / 1024 AS "FREE",
       d.status,
       a.cnt,
       d.contents,
       d.extent_management,
       d.segment_space_management
  FROM dba_tablespaces d,
       df a,
       (SELECT tablespace_name, SUM(bytes) bytes
          FROM dba_undo_extents
         where status in ('ACTIVE', 'UNEXPIRED')
         GROUP BY tablespace_name) u
 WHERE d.tablespace_name = a.tablespace_name(+)
   AND d.tablespace_name = u.tablespace_name(+)
   AND d.contents = 'UNDO'
 ORDER BY 1;
