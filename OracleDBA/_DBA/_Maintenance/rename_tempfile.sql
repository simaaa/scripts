select
  t.name, t.status,
  'ALTER DATABASE TEMPFILE ''' || t.name || ''' OFFLINE;' as set_offline,
  'ALTER DATABASE RENAME FILE ''' || t.name || ''' TO ''' || t.name || ''';' as change_ddl,
  'ALTER DATABASE TEMPFILE ''' || t.name || ''' ONLINE;' as set_online
from v$tempfile t where 1=1
--and t.status != 'ONLINE'
--and t.name like '%UTF99PARK%'
