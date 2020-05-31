--TAB=v$parameter
select round(t.value/1024/1024/1024,2) as gb, t.* from v$parameter t where t.name in ('memory_target','memory_max_target','sga_target','sga_max_size','pga_aggregate_target') order by t.name;
--TAB=v$memory_resize_ops
select t.* from v$memory_resize_ops t order by 1;
--TAB=v$sgainfo
select t.name, t.resizeable, t.bytes, round(t.bytes/1024/1024,2) as mb, round(t.bytes/1024/1024/1024,2) as gb from v$sgainfo t;
--TAB=v$memory_dynamic_components
select t.component, t.current_size, round(t.current_size/1024/1024,2) as mb, round(t.current_size/1024/1024/1024,2) as gb, t.* from v$memory_dynamic_components t;


-- https://oracle-base.com/articles/11g/automatic-memory-management-11gr1
-- https://docs.oracle.com/cd/B28359_01/server.111/b28310/memory003.htm#ADMIN11201

--ALTER SYSTEM RESET memory_max_target SCOPE=SPFILE;
--ALTER SYSTEM SET memory_target=4G SCOPE=SPFILE;

--ALTER SYSTEM SET PGA_AGGREGATE_TARGET=0 SCOPE=SPFILE;
--ALTER SYSTEM SET SGA_TARGET=0 SCOPE=SPFILE;
