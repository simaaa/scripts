--TAB=SESSIONS
SELECT t.* FROM dba_datapump_sessions t;
--TAB=JOBS
SELECT t.* FROM dba_datapump_jobs t;
--TAB=OBJECTS
SELECT o.status, o.object_id, o.object_type, o.owner || '.' || object_name "OWNER.OBJECT"
FROM dba_objects o, dba_datapump_jobs j
WHERE o.owner = j.owner_name
AND o.object_name =j.job_name
AND j.job_name NOT LIKE 'BIN$%'
ORDER BY 4,2;
