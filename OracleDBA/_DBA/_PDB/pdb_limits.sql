SELECT t.* FROM v$parameter t WHERE t.name like '%max_pdbs%';

/*
-- Limit the total storage of the the PDB (datafile and local temp files).
ALTER PLUGGABLE DATABASE STORAGE (MAXSIZE 5G);

-- Limit the amount of temp space used in the shared temp files.
ALTER PLUGGABLE DATABASE STORAGE (MAX_SHARED_TEMP_SIZE 2G);

-- Combine the two.
ALTER PLUGGABLE DATABASE STORAGE (MAXSIZE 5G MAX_SHARED_TEMP_SIZE 2G);

-- Remove the limits.
ALTER PLUGGABLE DATABASE STORAGE UNLIMITED;
*/
