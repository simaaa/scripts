select tp.* from dba_tab_partitions tp where 1=1
--and tp.table_owner like upper('%%')
--and tp.table_name like upper('%%')
--and tp.partition_position like upper('%%')
order by tp.table_owner, tp.table_name, tp.partition_position
;
