SELECT * FROM XMLTABLE(
  XMLNAMESPACES(DEFAULT 'http://xmlns.oracle.com/xdb/xdbconfig.xsd'),
  '/xdbconfig/sysconfig/protocolconfig/httpconfig/authentication/allow-mechanism'  
  PASSING DBMS_XDB.cfg_get() COLUMNS ordinality FOR ORDINALITY, auth_mechanism VARCHAR2(30) path '.'  
);
