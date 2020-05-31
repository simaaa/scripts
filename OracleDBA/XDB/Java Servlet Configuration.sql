DECLARE
  l_servlet_name VARCHAR2(32) := 'java_servlet_name';
BEGIN
  DBMS_XDB.deleteServletMapping(l_servlet_name);
  DBMS_XDB.deleteServlet(l_servlet_name);
  DBMS_XDB.addServlet(
    name     => l_servlet_name,
    language => 'Java',
    dispname => 'Oracle Query Web Service',
    descript => 'Servlet for issuing queries as a Web Service',
    class    => 'JavaServletClass',
    schema   => 'TEST');
  DBMS_XDB.addServletSecRole(
    servname => l_servlet_name,
    rolename => 'XDB_WEBSERVICES',
    rolelink => 'XDB_WEBSERVICES');
  DBMS_XDB.addServletMapping(
    pattern => '/' || l_servlet_name,
    name    => l_servlet_name);
  
  COMMIT;
END;
/

-- GET, POST
-- http://localhost:8080/java_servlet_name
-- http://localhost:8080/java_servlet_name?param1=value1
