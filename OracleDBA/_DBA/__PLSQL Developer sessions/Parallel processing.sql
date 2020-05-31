WITH px_session AS (
  SELECT
    qcsid, qcserial#, MAX(degree) degree, MAX(req_degree) req_degree, COUNT(*) no_of_processes
  FROM v$px_session p
  GROUP BY qcsid, qcserial#
)
SELECT
  s.username, s.sid, s.serial#, s.status,
  s.osuser, s.machine, s.program, s.module, s.action,
  p.degree, p.req_degree,
  p.no_of_processes as no_of_proc,
  sql.sql_text, s.sql_address, s.sql_hash_value
FROM v$session s
JOIN px_session p ON (s.sid = p.qcsid AND s.serial# = p.qcserial#)
JOIN v$sql sql ON (sql.sql_id = s.sql_id AND sql.child_number = s.sql_child_number)
