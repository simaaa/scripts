select unique grant_ddl
from (
    select 'grant execute on ' || referenced_name ||' to '|| owner ||';' grant_ddl
    from dba_dependencies
    where referenced_owner in ('SYS','PUBLIC')
    and referenced_type in ('PACKAGE','SYNONYM')
    and referenced_name not like '/%'
    and referenced_name in ('DBMS_RANDOM','DBMS_EXPORT_EXTENSION','UTL_FILE','DBMS_JOB','DBMS_LOB','UTL_SMTP','UTL_TCP','UTL_HTTP')
    and owner <> 'SYS'
    --and owner <> 'PUBLIC'
    and owner = 'XDB'
)
order by grant_ddl;
