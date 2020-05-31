SELECT
  (SELECT t1.username FROM gv$session t1 WHERE t1.sid = a.sid) blocker,
  a.sid,
  ' is blocking ',
  (SELECT t2.username FROM gv$session t2 WHERE t2.sid = b.sid) blockee,
  b.sid
FROM gv$lock a, gv$lock b
WHERE a.block = 1
AND b.request > 0
AND a.id1 = b.id1
AND a.id2 = b.id2
ORDER BY 1;
