SELECT
  s.sid, s.audsid, s.logon_time, s.username, s.status, s.state, s.schemaname, s.osuser, s.machine, s.terminal, s.program, s.action, s.module, s.client_info, s.external_name,
  i.instance_number, i.instance_name, i.host_name
FROM
  gv$session s, gv$instance i
WHERE s.inst_id = s.inst_id
AND s.username IS NOT NULL
AND s.terminal NOT LIKE '%RAC%';
