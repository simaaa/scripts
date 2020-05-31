--TAB=COUNT
select count(1) from sys.aud$ t;

--TAB=AUD$
select t.* from sys.aud$ t;

--TAB=DBA_AUDIT_TRAIL
select
  decode(        -- order: ALTER, AUDIT, COMMENT, DELETE, GRANT, INDEX, INSERT, LOCK, RENAME, SELECT, UPDATE, REFERENCES, and EXECUTE
    ses_actions, -- values: none=-, success=S, failure=F, both=B
    '---S------------', 'DELETE',
    '------S---------', 'INSERT',
    '---------S------', 'SELECT',
    '----------S-----', 'UPDATE',
    '---S--S--S------', 'DELETE/INSERT/SELECT',
    '---S--S--SS-----', 'DELETE/INSERT/SELECT/UPDATE',
    '------S--S------', 'INSERT/SELECT',
    '------S--SS-----', 'INSERT/SELECT/UPDATE',
    '---------SS-----', 'SELECT/UPDATE',
    'UNKNOWN'
  ) as ACTION,
  t.*
from dba_audit_trail t;
