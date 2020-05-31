SELECT
  PLAN_TABLE_OUTPUT ||
  CASE 
    WHEN LOAD >0 THEN TO_CHAR(100*LOAD,'999')||'%' -- ASH load to be displayed
    WHEN REGEXP_LIKE (PLAN_TABLE_OUTPUT,'^[|] *Id *[|]')  THEN ' %ASH' -- header
  END plan_table_output 
from (
  -- get dbms_xplan result
  select 
    n,plan_table_output
    -- get sql_id from plan_table output
    ,max(case when regexp_like(plan_table_output,'^SQL_ID +([^,]+), child number ([0-9]+).*$') then
    regexp_replace(plan_table_output,'^SQL_ID +([^,]+), child number ([0-9]+).*$','\1')
    end)over() sql_id
    -- get child number from plan_table output
    ,max(case when regexp_like(plan_table_output,'^SQL_ID +([^,]+), child number ([0-9]+).*$') then
    regexp_replace(plan_table_output,'^SQL_ID +([^,]+), child number ([0-9]+).*$','\2')
    end)over() sql_child_number
    -- get plan hash value from plan_table output
    ,max(case when regexp_like(plan_table_output,'^Plan hash value: +([^,]+).*$') then
    regexp_replace(plan_table_output,'^Plan hash value: +([^,]+).*$','\1')
    end)over() sql_plan_hash_value
    -- get plan line id from plan_table output
    ,case when regexp_like (plan_table_output,'^[|][*]? *([0-9]+) *[|].*[|]$') then
    regexp_replace(plan_table_output,'^[|][*]? *([0-9]+) *[|].*[|]$','\1') 
    END SQL_PLAN_LINE_ID
  from (select rownum n,plan_table_output from table(dbms_xplan.display_cursor('81001r7rrtwp1',0,'ALLSTATS LAST +cost +bytes')))
) p
left outer join (
  -- get ASH samples
  select sql_id,sql_plan_line_id,sql_child_number,sql_plan_hash_value,round(count(*)/"samples",2) load 
  from (
    select sql_id,sql_plan_line_id,sql_child_number,sql_plan_hash_value,count(*) over (partition by sql_id,sql_plan_hash_value) "samples" 
    FROM V$ACTIVE_SESSION_HISTORY
    --where sql_id = xplan_with_ash_pct.SQL_ID and sql_child_number = nvl(xplan_with_ash_pct.CURSOR_CHILD_NO,0)
  ) group by sql_id,sql_plan_line_id,sql_child_number,sql_plan_hash_value,"samples"
) a 
using(sql_id,sql_plan_line_id,sql_plan_hash_value)  
order by sql_id,sql_plan_hash_value,n
