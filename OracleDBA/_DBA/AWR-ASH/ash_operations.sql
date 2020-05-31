select distinct ash.sql_id, ash.program, ash.sql_child_number, ash.sql_opname, ash.sql_plan_operation || ' ' || ash.sql_plan_options as PLAN_OPERATION
from
  gv$active_session_history ash,
  (
    select inst_id, sql_exec_start, sql_id, sql_exec_id
    from (
      select inst_id, sql_exec_start, sql_opname, sql_id, sql_exec_id, program, count(distinct sql_child_number)
      from gv$active_session_history
      where sql_exec_id is not null
      group by inst_id, sql_exec_start, sql_opname, sql_id, sql_exec_id, program
      having count(distinct sql_child_number) > 1
      order by count(distinct sql_child_number) desc
    )
    where rownum <= 1
  ) sec -- sql_exec2child
where ash.sql_id = sec.sql_id
and ash.sql_exec_id = sec.sql_exec_id
and ash.sql_exec_start = sec.sql_exec_start
order by 1, 2
