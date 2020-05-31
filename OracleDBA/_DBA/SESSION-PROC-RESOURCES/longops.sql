SELECT
       ROUND(sl.elapsed_seconds/60) || ':' || MOD(sl.elapsed_seconds,60) elapsed,
       ROUND(sl.time_remaining/60) || ':' || MOD(sl.time_remaining,60) remaining,
       ROUND(sl.sofar/sl.totalwork*100, 2) progress_pct,
       sl.start_time,
       (SYSDATE+sl.time_remaining/86400) predicted_finish,
       s.sid, s.serial#,
       s.username, s.osuser, s.machine, s.module, s.action,
       sl.opname, sl.target, sl.target_desc
       ,sl.*
FROM   v$session s, v$session_longops sl
WHERE  s.sid     = sl.sid
AND    s.serial# = sl.serial#
--AND    sl.time_remaining > 0
ORDER BY sl.start_time;
