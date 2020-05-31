-- Generating monthly partition splitter DDL commands if SPLITTABLE partition exists
DECLARE
  v_table_owner          VARCHAR2(100)    := 'DM_IFRS';
  v_table_name           VARCHAR2(100)    := 'AB_NAPI_JZB_CF_J_PART';
  v_tablespace_prefix    VARCHAR2(100)    := 'DM_CDAT_Y';      -- Partition tablespace name prefix
  v_part_date_start      DATE             := DATE'2017-01-01'; -- Month of first partition
  v_part_date_end        DATE             := DATE'2019-02-01'; -- Month of last Partition
  v_split_part_name      VARCHAR2(100)    := 'M999912';        -- Splittable partition name.  ('M999912','M201711')
  
  v_sql                  VARCHAR2(4000);                       -- DDL command
  v_table_max_part_date  DATE             := NULL;             -- Maximum date of table partition
  DBMS_DEBUG             CONSTANT BOOLEAN := TRUE;             -- Writing DDL command to DBMS_OUTPUT
  MULTILINE              CONSTANT BOOLEAN := TRUE;             -- Writing output in multiple lines
  WITH_UPDATE_IDX        CONSTANT BOOLEAN := TRUE;             -- Generatin DDL command with 'UPDATE INDEXES' option
  
  -- Monthly calendar cursor
  CURSOR cur_calendar(i_StartDate IN DATE, i_EndDate IN DATE) IS
    SELECT ADD_MONTHS(trunc(i_StartDate,'MM'),level-1) DAY, 'M'||TO_CHAR(ADD_MONTHS(trunc(i_StartDate,'MM'),level-1),'YYYYMM') AS PART_NAME FROM dual CONNECT BY TRUNC(i_EndDate,'MM') >= ADD_MONTHS( TRUNC(i_StartDate,'MM'), level-1 );

BEGIN
  -- Checking splittable table partition
  SELECT p.partition_name INTO v_sql FROM dba_tab_partitions p WHERE p.table_owner = v_table_owner AND p.table_name = v_table_name AND p.partition_name = v_split_part_name;
  
  -- Query date of maximum partition
  SELECT NVL(TO_DATE(SUBSTR(MAX(p.partition_name),2),'YYYYMM'),ADD_MONTHS(v_part_date_start,-1)) INTO v_table_max_part_date FROM dba_tab_partitions p WHERE p.table_owner = v_table_owner AND p.table_name = v_table_name AND ( ( v_split_part_name LIKE '%9999%' AND p.partition_name != v_split_part_name ) OR ( v_split_part_name NOT LIKE '%9999%' AND p.partition_name  = v_split_part_name ) );
  IF DBMS_DEBUG THEN DBMS_OUTPUT.PUT_LINE( '-- Date of maximum partition: ' || TO_CHAR(v_table_max_part_date,'YYYY.MM.DD') ); END IF;
  
  FOR cur IN cur_calendar(v_part_date_start,v_part_date_end) LOOP --DBMS_OUTPUT.PUT_LINE( TO_CHAR(cur.day,'YYYY.MM.DD') || ' - ' || cur.part_name );
    IF INSTR(v_split_part_name,'9999')>0 THEN
      IF cur.day <= v_table_max_part_date THEN CONTINUE; END IF;
    ELSE
      IF cur.day >= v_table_max_part_date THEN CONTINUE; END IF;
    END IF;
    v_sql := 'ALTER TABLE ' || v_table_owner || '.' || v_table_name || ' SPLIT PARTITION ' || v_split_part_name || ' AT' || CASE WHEN MULTILINE THEN CHR(13) ELSE NULL END ||
             '       ( TO_DATE('' ' || TO_CHAR(ADD_MONTHS(cur.day,1),'YYYY-MM-DD HH24:MI:SS') || ''', ''SYYYY-MM-DD HH24:MI:SS'') )' || CASE WHEN MULTILINE THEN CHR(13) ELSE NULL END ||
             '  INTO ( PARTITION ' || cur.part_name || ' TABLESPACE ' || v_tablespace_prefix || TO_CHAR(cur.day,'YYYY') || ', ' ||
             'PARTITION ' || v_split_part_name || ' TABLESPACE ' || v_tablespace_prefix || TO_CHAR(cur.day,'YYYY') || ' )' || CASE WHEN WITH_UPDATE_IDX THEN ' UPDATE INDEXES' ELSE NULL END;
    IF DBMS_DEBUG THEN DBMS_OUTPUT.PUT_LINE( v_sql || ';' || CHR(13) ); END IF;
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE( 'Not found ''' || v_table_owner || '.' || v_table_name ||''' table or ''' || v_split_part_name || ''' table partition!' );
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE( SQLERRM );
END;
/
