-- https://oracle-base.com/dba/script?category=monitoring&file=hidden_parameters.sql
SELECT a.ksppinm AS parameter,
       a.ksppdesc AS description,
       b.ksppstvl AS session_value,
       c.ksppstvl AS instance_value,
       c.ksppstdf AS default_value
FROM   x$ksppi a,
       x$ksppcv b,
       x$ksppsv c
WHERE  a.indx = b.indx
AND    a.indx = c.indx
--AND    a.ksppinm LIKE '%_system_trig_enabled%'
ORDER BY a.ksppinm;
