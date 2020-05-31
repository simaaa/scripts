SELECT t.*, CASE WHEN t.procedure IS NULL THEN NULL ELSE 'EXEC ' || t.procedure || ';' END AS validate_ddl FROM dba_registry t WHERE 1=1
--AND t.status != 'VALID'
--AND t.comp_id = 'XDB'
ORDER BY t.comp_id;
