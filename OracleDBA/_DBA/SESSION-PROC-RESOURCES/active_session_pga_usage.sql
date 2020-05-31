--TAB=TOTAL_PGA
SELECT
  ROUND(SUM(pga_used_mem)/(1024*1024),2) PGA_USED_MB,
  ROUND(SUM(pga_used_mem)/(1024*1024*1024),2) PGA_USED_GB
FROM v$process;

--TAB=SESSION_PGA_USAGE
SELECT
  DECODE(TRUNC(SYSDATE - LOGON_TIME), 0, NULL, TRUNC(SYSDATE - LOGON_TIME) || 'days + ') || TO_CHAR(TO_DATE(TRUNC(MOD(SYSDATE-LOGON_TIME,1) * 86400), 'SSSSS'), 'HH24:MI:SS') LOGON,
  SID, s.SERIAL#, p.SPID,
  ROUND(p.pga_used_mem/(1024*1024), 2) PGA_USED_MB,
  ROUND(p.pga_used_mem/(1024*1024*1024), 2) PGA_USED_GB,
  s.USERNAME, s.STATUS, s.OSUSER, s.MACHINE, s.PROGRAM, s.MODULE, s.ACTION--,s.BLOCKING_INSTANCE, s.BLOCKING_SESSION
FROM v$session s, v$process p
WHERE s.paddr = p.addr 
--AND s.sid = 0 AND s.serial# = 0 --AND p.spid = 24301
AND p.pga_used_mem/(1024*1024) > 1
--AND s.status = 'ACTIVE'
--AND s.username = 'SYSTEM'
ORDER BY p.pga_used_mem DESC;

/*
--TAB=SESSION_PGA_STAT
SELECT
  SID, b.NAME,
  ROUND(a.VALUE/(1024*1024),2) MB,
  ROUND(a.VALUE/(1024*1024*1024),2) GB
FROM v$sesstat a,  v$statname b
WHERE (NAME LIKE '%session uga memory%' OR NAME LIKE '%session pga memory%')
AND a.statistic# = b.statistic# 
AND SID = 1027; -- !!! SET SID !!!
*/
