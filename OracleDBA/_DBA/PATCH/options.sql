select t.* from v$option t where 1=1
--and t.value = 'TRUE'
--and upper(t.PARAMETER) like upper('%database%')
and upper(t.PARAMETER) like upper('%vault%')
