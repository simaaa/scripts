--ALTER USER ANONYMOUS ACCOUNT UNLOCK;
--EXEC DBMS_XDB.cfg_refresh;

SELECT
  DBMS_XDB.getHTTPPort, -- EXEC DBMS_XDB.setHTTPPort(8080);
  DBMS_XDB.getFTPPort, -- EXEC DBMS_XDB.setFTPPort(2121);
  DBMS_XDB.cfg_get(),
  xdburitype('/sys/schemas/PUBLIC/xmlns.oracle.com/xdb/XDBResource.xsd').getxml() AS XDBResource,
  xdburitype('/sys/schemas/PUBLIC/xmlns.oracle.com/xdb/xdbconfig.xsd').getxml() AS xdbconfig
FROM DUAL;

-- APEX URLs: http://<HOST>:<PORT>/apex, http://<HOST>:<PORT>/apex/apex_admin
