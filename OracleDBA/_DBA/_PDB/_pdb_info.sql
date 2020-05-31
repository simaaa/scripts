--TAB=CONFIG
SELECT t.cdb FROM v$database t;

--TAB=SERVICES
SELECT PDB, NETWORK_NAME, CON_ID FROM CDB_SERVICES
WHERE PDB IS NOT NULL AND CON_ID > 2
ORDER BY PDB;

--TAB=PDB HISTORY
SELECT DB_NAME, CON_ID, PDB_NAME, OPERATION, OP_TIMESTAMP, CLONED_FROM_PDB_NAME
FROM CDB_PDB_HISTORY
WHERE CON_ID > 2
ORDER BY CON_ID;

--TAB=DBA_PDB_SAVED_STATES
SELECT con_name, instance_name, state FROM dba_pdb_saved_states;

--TAB=DBA_PDB
SELECT t.pdb_id, t.pdb_name, t.logging, t.status, t.force_logging, t.force_nologging --, t.*
FROM dba_pdbs t ORDER BY t.pdb_id;

--TAB=V$PDBS
SELECT
  t.con_id, t.dbid, t.name, t.open_mode, t.restricted, t.proxy_pdb, t.open_time,
  CASE WHEN con_id <3 THEN NULL ELSE 'ALTER PLUGGABLE DATABASE ' || t.name || ' SAVE STATE;' END AS SAVE_STATE,
  CASE WHEN con_id <3 THEN NULL ELSE 'ALTER SESSION SET CONTAINER=' || t.name || ';' END AS SET_CMD
  --, t.*
FROM v$pdbs t ORDER BY t.con_id;
