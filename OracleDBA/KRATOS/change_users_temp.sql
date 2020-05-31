select
  t.username, t.account_status, t.temporary_tablespace,
  'alter user ' || t.username || ' temporary tablespace TEMP;' AS change_temp_tablespace
from dba_users t
where t.username not in ('DUMP_MASTER',
  'ANONYMOUS','APEX_030200','APEX_PUBLIC_USER','APPQOSSYS','CTXSYS','DBSNMP','DIP','DMSYS','EXFSYS','FLOWS_FILES',
  'LBACSYS','MDDATA','MDSYS','MGMT_VIEW','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','OWBSYS','OWBSYS_AUDIT',
  'SCOTT','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSMAN','SYSTEM','TSMSYS','WMSYS','XDB','XS$NULL'
)
order by t.username;
