select t.object_name, t.owner, t.original_name, 'purge table ' || t.owner || '.' || t.original_name || ';' AS PURGE_DDL
from dba_recyclebin t
group by t.object_name, t.owner, t.original_name
order by t.owner, t.original_name;
