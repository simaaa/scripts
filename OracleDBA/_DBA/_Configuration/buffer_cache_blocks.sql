-- SHOW PARAMETER db_cache_size;
-- ALTER SYSTEM FLUSH BUFFER_CACHE;
-- TAB=TOTAL NON FREE BLOCKS
SELECT COUNT(*) AS number_of_non_free_block
FROM dba_objects o, v$bh bh
WHERE o.data_object_id = bh.OBJD AND o.owner != 'SYS' AND bh.status != 'free';

-- TAB=NON FREE OBJECT BLOCKS
SELECT o.object_name, COUNT(*) number_of_non_free_blocks
FROM dba_objects o, v$bh bh
WHERE o.data_object_id = bh.OBJD AND o.owner != 'SYS' AND bh.status != 'free'
GROUP BY o.object_Name
ORDER BY 2 DESC;
