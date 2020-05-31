--CREATE OR REPLACE VIEW V_SIZE_TABLES AS
SELECT owner, table_name, MB, GB
FROM (
      SELECT owner, table_name, SUM(bytes)/(1024*1024) MB, TRUNC(SUM(bytes)/(1024*1024*1024)) GB
      FROM (
              SELECT segment_name table_name, owner, bytes
              FROM dba_segments
              WHERE segment_type LIKE '%TABLE%'
             UNION ALL
              SELECT i.table_name, i.owner, s.bytes
              FROM dba_indexes i, dba_segments s
              WHERE s.segment_name = i.index_name
              AND   s.owner = i.owner
              AND   s.segment_type LIKE '%INDEX%'
             UNION ALL
              SELECT l.table_name, l.owner, s.bytes
              FROM dba_lobs l, dba_segments s
              WHERE s.segment_name = l.segment_name
              AND   s.owner = l.owner
              AND   s.segment_type LIKE '%LOB%'
      )
      GROUP BY table_name, owner
)
--WHERE owner NOT IN ('SYS','SYSTEM','SYSMAN','DBSNMP','ORDSYS','ORDDATA','OLAPSYS','EXFSYS','LBACSYS','MDSYS','DMSYS','CTXSYS','TSMSYS','WMSYS','WKSYS','WK_TEST','XDB','OUTLN','APEX_030200','FLOWS_FILES','FLOWS_030000')
WHERE owner = UPPER('&OWNER')
AND table_name LIKE UPPER('%&SEARCH%')
--AND UPPER(table_name) = UPPER('&tablename')
ORDER BY MB DESC
;
