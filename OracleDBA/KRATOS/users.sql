select t.*
from dba_users t
where t.username not in ('DUMP_MASTER',
  'ANONYMOUS','APEX_030200','APEX_PUBLIC_USER','APPQOSSYS','CTXSYS','DBSNMP','DIP','DMSYS','EXFSYS','FLOWS_FILES',
  'LBACSYS','MDDATA','MDSYS','MGMT_VIEW','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','OWBSYS','OWBSYS_AUDIT',
  'SCOTT','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSMAN','SYSTEM','TSMSYS','WMSYS','XDB','XS$NULL'
)
order by t.username;

/*
ALTER USER unikerall GRANT CONNECT THROUGH admin;
ALTER USER park GRANT CONNECT THROUGH admin;

drop user orasource cascade;
create user orasource identified by srcora;
alter user orasource identified by srcora;
grant connect, resource to orasource;
grant select_catalog_role to orasource;
grant select on sys.obj$ to orasource;
grant select on sys.snap$ to orasource;
grant select on REDGATE.LOCKED_OBJECTS to orasource;

drop user noc cascade;
create user noc identified by sysmanager1;
grant dba to noc;

drop user moszab cascade;
create user moszab identified by sysmanager1;
grant dba to moszab;
ALTER USER park GRANT CONNECT THROUGH moszab;
ALTER USER unikerall GRANT CONNECT THROUGH moszab;
*/
