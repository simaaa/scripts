--TAB=CONFIG
SELECT * FROM dba_hist_wr_control;

--TAB=SNAPSHOTS
SELECT snap_id, begin_interval_time, end_interval_time FROM dba_hist_snapshot ORDER BY snap_id;

--TAB=DROP AWR SNAPSHOTS
SELECT
  MIN(snap_id),
  MAX(snap_id),
  'EXEC DBMS_WORKLOAD_REPOSITORY.DROP_SNAPSHOT_RANGE( low_snap_id=>' || NVL(MIN(snap_id),0) || ', high_snap_id=>' || NVL(MAX(snap_id),1) || ');' AS DROP_DDL
FROM dba_hist_snapshot;
