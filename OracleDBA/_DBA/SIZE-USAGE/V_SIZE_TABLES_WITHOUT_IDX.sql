--CREATE OR REPLACE VIEW V_SIZE_TABLES_WITHOUT_IDX AS
SELECT owner, table_name, MB, GB
FROM (
      SELECT owner, table_name, SUM(bytes)/(1024*1024) MB, TRUNC(SUM(bytes)/(1024*1024*1024)) GB
      FROM (
              SELECT segment_name table_name, owner, bytes
              FROM dba_segments
              WHERE segment_type LIKE '%TABLE%'
             UNION ALL
              SELECT l.table_name, l.owner, s.bytes
              FROM dba_lobs l, dba_segments s
              WHERE s.segment_name = l.segment_name
              AND   s.owner = l.owner
              AND   s.segment_type LIKE '%LOB%'
      )
      GROUP BY table_name, owner
)
WHERE OWNER NOT IN ('SYS','SYSTEM','SYSMAN','DBSNMP','ORDSYS','ORDDATA','OLAPSYS','EXFSYS','LBACSYS','MDSYS','DMSYS','CTXSYS','TSMSYS','WMSYS','WKSYS','WK_TEST','XDB','OUTLN','APEX_030200','FLOWS_FILES','FLOWS_030000')
AND UPPER(table_name) = UPPER('&tablename')
ORDER BY MB DESC
;
