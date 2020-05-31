SELECT
  --USERENV('INSTANCE') ||' ('|| SYS_CONTEXT('USERENV','INSTANCE_NAME') ||')' AS CONNECTED_INSTANCE,
  DECODE(i.INSTANCE_NUMBER,USERENV('INSTANCE'),'CONNECTED') AS CURR_SESSION_CONNECTED,
  i.INSTANCE_NUMBER,
  i.INSTANCE_NAME,
  i.HOST_NAME,
  i.STARTUP_TIME,
  i.LOGINS,
  i.STATUS,
  i.DATABASE_STATUS,
  i.SHUTDOWN_PENDING,
  i.ACTIVE_STATE,
  i.BLOCKED,
  i.ARCHIVER,
  i.LOG_SWITCH_WAIT
  --i.INST_ID, i.VERSION, i.THREAD#, i.INSTANCE_ROLE, i.CON_ID, i.INSTANCE_MODE, i.EDITION, i.FAMILY, i.PARALLEL, 
FROM
  gv$instance i
--WHERE i.instance_number = USERENV('INSTANCE')