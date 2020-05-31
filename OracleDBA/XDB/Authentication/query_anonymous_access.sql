SELECT * FROM XMLTABLE(
  XMLNAMESPACES(DEFAULT 'http://xmlns.oracle.com/xdb/xdbconfig.xsd'),
  '/xdbconfig/sysconfig/protocolconfig/httpconfig/allow-repository-anonymous-access'  
  PASSING DBMS_XDB.cfg_get() COLUMNS ordinality FOR ORDINALITY, anonymous_access VARCHAR2(10) path '.'  
);
