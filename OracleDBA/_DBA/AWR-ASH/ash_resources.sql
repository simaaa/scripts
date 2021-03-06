-- SESSION HIST COUNT PER MINUTE
SELECT TO_CHAR(SAMPLE_TIME, 'YYYY.MM.DD. HH24:MI:SS') AS SAMPLE_TIME,
       ROUND(OTHER / 60, 3) AS OTHER,
       ROUND(CLUST / 60, 3) AS CLUST,
       ROUND(QUEUEING / 60, 3) AS QUEUEING,
       ROUND(NETWORK / 60, 3) AS NETWORK,
       ROUND(ADMINISTRATIVE / 60, 3) AS ADMINISTRATIVE,
       ROUND(CONFIGURATION / 60, 3) AS CONFIGURATION,
       ROUND(COMMIT / 60, 3) AS COMMIT,
       ROUND(APPLICATION / 60, 3) AS APPLICATION,
       ROUND(CONCURRENCY / 60, 3) AS CONCURRENCY,
       ROUND(SIO / 60, 3) AS SYSTEM_IO,
       ROUND(UIO / 60, 3) AS USER_IO,
       ROUND(SCHEDULER / 60, 3) AS SCHEDULER,
       CPU as CPU_ALL,
       ROUND(CPU / 60, 3) AS CPU,
       ROUND(BCPU / 60, 3) AS BACKGROUND_CPU
  FROM (SELECT TRUNC(SAMPLE_TIME, 'MI') AS SAMPLE_TIME,
               DECODE(SESSION_STATE,
                      'ON CPU',
                      DECODE(SESSION_TYPE, 'BACKGROUND', 'BCPU', 'ON CPU'),
                      WAIT_CLASS) AS WAIT_CLASS
          FROM V$ACTIVE_SESSION_HISTORY
         WHERE SAMPLE_TIME > SYSDATE - INTERVAL '4' HOUR
           AND SAMPLE_TIME <= TRUNC(SYSDATE, 'MI')
) ASH PIVOT(
  COUNT(*) FOR WAIT_CLASS IN(
    'ON CPU' AS CPU,'BCPU' AS BCPU,
    'Scheduler' AS SCHEDULER,
    'User I/O' AS UIO,
    'System I/O' AS SIO, 
    'Concurrency' AS CONCURRENCY,                                                                               
    'Application' AS  APPLICATION,                                                                                  
    'Commit' AS  COMMIT,                                                                             
    'Configuration' AS CONFIGURATION,                     
    'Administrative' AS   ADMINISTRATIVE,                                                                                 
    'Network' AS  NETWORK,                                                                                 
    'Queueing' AS   QUEUEING,                                                                                  
    'Cluster' AS   CLUST,                                                                                      
    'Other' AS  OTHER
  )
)
WHERE SAMPLE_TIME BETWEEN timestamp'2018-11-16 08:01:00' AND timestamp'2018-11-16 09:01:00'
ORDER BY 1 desc
