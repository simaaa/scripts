select *
from table(
  DBMS_XPLAN.DISPLAY_cursor(:sql_id,0,'ALLSTATS LAST +cost +bytes')
);
