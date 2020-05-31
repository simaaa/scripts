SELECT
  DECODE(px.qcinst_id, NULL, username, ' - ' || LOWER(pp.SERVER_NAME) ) AS "Username",
  DECODE(px.qcinst_id, NULL, 'QC', '(Slave)')                           AS "QC/Slave" ,
  px.server_set                                                         AS "SlaveSet",
  s.program, s.module, s.action,
  s.SID                                                                 AS "SID",
  s.serial#,
  px.inst_id                                                            AS "Slave INST",
  DECODE(sw.state, 'WAITING', 'WAIT', 'NOT WAIT')                       AS "STATE",
  CASE sw.state WHEN 'WAITING' THEN SUBSTR(sw.event,1,30) ELSE NULL END AS "Wait event",
  DECODE(px.qcinst_id, NULL, TO_CHAR(s.SID), px.qcsid)                  AS "QC SID",
  px.qcinst_id                                                          AS "QC INST",
  px.req_degree                                                         AS "Req DOP",
  px.DEGREE                                                             AS "Actual DOP", 
  DECODE(px.server_set, '', s.last_call_et, '')                         AS "Elapsed seconds"
  ,pp.spid
FROM gv$px_session px
LEFT OUTER JOIN gv$session s       ON px.SID = s.SID AND px.serial# = s.serial# AND px.inst_id = s.inst_id
LEFT OUTER JOIN gv$px_process pp   ON px.SID = pp.SID AND px.serial# = pp.serial#
LEFT OUTER JOIN gv$session_wait sw ON sw.SID = s.SID AND sw.inst_id = s.inst_id
WHERE 1=1
AND DECODE(px.qcinst_id, NULL, TO_CHAR(s.SID), px.qcsid) = :sid
ORDER BY DECODE(px.QCINST_ID,  NULL, px.INST_ID,  px.QCINST_ID), px.QCSID, DECODE(px.SERVER_GROUP, NULL, 0, px.SERVER_GROUP), px.SERVER_SET, px.INST_ID;
