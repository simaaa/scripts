--TAB=MEMORY
select round(t.value/1024/1024/1024,2) as gb, t.* from v$parameter t where t.name in ('memory_target','memory_max_target','sga_target','sga_max_size','pga_aggregate_target') order by t.name;
--TAB=CONTROL FILES
select distinct level, trim(REGEXP_SUBSTR(t.value,'[^,]+', 1, level)) as control_file from v$parameter t where t.name like '%control_files%' connect by trim(REGEXP_SUBSTR(t.value, '[^,]+', 1, level)) is not null order by level;
--TAB=FRA
select t.* from v$parameter t where t.name like 'db_recovery%';

/*
HOST clear;
COLUMN name FORMAT A20;
select t.name, round(t.value/1024/1024/1024,2) as gb from v$parameter t where t.name in ('memory_target','memory_max_target','sga_target','sga_max_size','pga_aggregate_target') order by t.name;
alter system set memory_max_target=1G scope=spfile;
alter system set memory_target=1G scope=spfile;
alter system set sga_max_size=1G scope=spfile;
alter system reset db_recovery_file_dest_size scope=spfile;
alter system reset db_recovery_file_dest scope=spfile;
create pfile from spfile;
shutdown immediate;

-- !!! CONFIGURE CONTROLFILE !!!
create spfile from pfile;
startup;
*/
