select t.username from dba_users t where 1=1
and t.username not in (select schema from dba_registry)                            -- Oracle internal components
and t.username not like '%APEX%' and t.username not in ('ANONYMOUS','FLOWS_FILES') -- APEX
and t.username not in ( -- Other Oracle components
  'ANONYMOUS','APEX_030200','APEX_PUBLIC_USER',
  'APPQOSSYS','CTXSYS','DBSNMP','DIP','DMSYS','EXFSYS','FLOWS_FILES',
  'LBACSYS','MDDATA','MDSYS','MGMT_VIEW','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','OWBSYS','OWBSYS_AUDIT',
  'SCOTT','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSMAN','SYSTEM','TSMSYS','WMSYS','XDB','XS$NULL'
)
order by t.username;
