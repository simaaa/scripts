select t.* from v$parameter t where t.name like '%control_files%';

select
  TRIM(REGEXP_SUBSTR(t.value, '[^,]+', 1, 1)) as ctl_01,
  TRIM(REGEXP_SUBSTR(t.value, '[^,]+', 1, 2)) as ctl_02,
  TRIM(REGEXP_SUBSTR(t.value, '[^,]+', 1, 3)) as ctl_03,
  TRIM(REGEXP_SUBSTR(t.value, '[^,]+', 1, 4)) as ctl_04
from v$parameter t
where t.name like '%control_files%';

select TRIM(REGEXP_SUBSTR('AA, BB, CC', '[^,]+', 1, level))
from dual
connect by REGEXP_SUBSTR('AA, BB, CC', '[^,]+', 1, level) is not null;

select distinct level, trim(REGEXP_SUBSTR(t.value,'[^,]+', 1, level)) as control_file
from v$parameter t
where t.name like '%control_files%'
connect by trim(REGEXP_SUBSTR(t.value, '[^,]+', 1, level)) is not null
order by level;
