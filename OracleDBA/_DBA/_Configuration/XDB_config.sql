--TAB=CONFIGURATION
select DBMS_XDB.getHTTPPort, DBMS_XDB.getFTPPort, DBMS_XDB.cfg_get from dual;

--TAB=CONTENT
select t.* from resource_view t where t.any_path like '/sys/schemas%' and t.any_path not like '/sys/schemas/PUBLIC%' order by t.any_path;

--TAB=AUTH METHODS
SELECT * FROM XMLTABLE(
  XMLNAMESPACES(DEFAULT 'http://xmlns.oracle.com/xdb/xdbconfig.xsd'),
  '/xdbconfig/sysconfig/protocolconfig/httpconfig/authentication/allow-mechanism'  
  PASSING DBMS_XDB.cfg_get() COLUMNS ordinality FOR ORDINALITY, auth_mechanism VARCHAR2(30) path '.'  
);

--TAB=SERVLETS
SELECT t.* FROM XMLTable( XMLNAMESPACES(DEFAULT 'http://xmlns.oracle.com/xdb/xdbconfig.xsd'), '//servlet-list/*' PASSING DBMS_XDB.CFG_GET()
  COLUMNS
    SERVLET          VARCHAR2(15) PATH '/servlet/servlet-name/text()',
    SERVLET_LANGUAGE VARCHAR2(20) PATH '/servlet/servlet-language/text()',
    DISPLAY_NAME     VARCHAR2(100) PATH '/servlet/display-name/text()',
    DESCRIPTION      VARCHAR2(100) PATH '/servlet/description/text()',
    SERVLET_CLASS    VARCHAR2(100) PATH '/servlet/servlet-class/text()',
    SERVLET_SCHEMA   VARCHAR2(100) PATH '/servlet/servlet-schema/text()'
) t;

/*
CALL DBMS_XDB.setHTTPPort(10008);
CALL DBMS_XDB.setFTPPort(21);

-- CALL-TIMEOUT: DEFAULT VALUE=6000 (60 seconds) - ORACLE RECOMMENDED VALUE: 300 (3 seconds)
CALL DBMS_XDB.cfg_update( updateXML(DBMS_XDB.cfg_get(),'/xdbconfig/sysconfig/call-timeout/text()','300','xmlns="http://xmlns.oracle.com/xdb/xdbconfig.xsd"') );

-- LOGGING - DEFAULT VALUES: xdbcore-logfile-path=/sys/log/xdblog.xml, xdbcore-log-level=0)
CALL DBMS_XDB.cfg_update( updateXML(DBMS_XDB.cfg_get(),'/xdbconfig/sysconfig/xdbcore-logfile-path/text()','/home/oracle/bin/.ORACLE_LOGs/xdblog.xml','xmlns="http://xmlns.oracle.com/xdb/xdbconfig.xsd"') );
CALL DBMS_XDB.cfg_update( updateXML(DBMS_XDB.cfg_get(),'/xdbconfig/sysconfig/xdbcore-log-level/text()','7','xmlns="http://xmlns.oracle.com/xdb/xdbconfig.xsd"') );
*/
