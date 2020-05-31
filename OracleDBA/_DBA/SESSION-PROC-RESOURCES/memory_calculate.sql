-- https://oracle-base.com/articles/11g/automatic-memory-management-11gr1
-- https://docs.oracle.com/cd/B28359_01/server.111/b28310/memory003.htm#ADMIN11201

--TAB=Configuration
SELECT name, value, 1 as orderr FROM v$parameter WHERE name IN ('pga_aggregate_target', 'sga_target')
UNION
SELECT 'maximum PGA allocated' AS name, TO_CHAR(value) AS value, 2 as orderr FROM v$pgastat WHERE name = 'maximum PGA allocated'
ORDER BY orderr;

--TAB=Calculate MEMORY_TARGET
SELECT
  sga.value + GREATEST(pga.value, max_pga.value) AS memory_target,
  ROUND((sga.value + GREATEST(pga.value, max_pga.value))/1024/1024,2) AS memory_target_mb,
  ROUND((sga.value + GREATEST(pga.value, max_pga.value))/1024/1024/1024,2) AS memory_target_gb
FROM (SELECT TO_NUMBER(value) AS value FROM v$parameter WHERE name = 'sga_target') sga,
     (SELECT TO_NUMBER(value) AS value FROM v$parameter WHERE name = 'pga_aggregate_target') pga,
     (SELECT value FROM v$pgastat WHERE name = 'maximum PGA allocated') max_pga;
