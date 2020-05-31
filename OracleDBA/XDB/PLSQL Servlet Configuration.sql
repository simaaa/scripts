DECLARE
  l_servlet_name VARCHAR2(32) := 'orawsv';
BEGIN
  DBMS_XDB.deleteServletMapping(l_servlet_name);
  DBMS_XDB.deleteServlet(l_servlet_name);
  DBMS_XDB.addServlet(
    name     => l_servlet_name,
    language => 'C',
    dispname => 'Oracle Query Web Service',
    descript => 'Servlet for issuing queries as a Web Service',
    schema   => 'XDB');
  DBMS_XDB.addServletSecRole(
    servname => l_servlet_name,
    rolename => 'XDB_WEBSERVICES',
    rolelink => 'XDB_WEBSERVICES');
  DBMS_XDB.addServletMapping(
    pattern => '/' || l_servlet_name || '/*',
    name    => l_servlet_name);
  COMMIT;
END;
/

-- GET, POST
-- http://localhost:8080/orawsv/TEST/GET_DESCRIPTION?WSDL
-- http://test:test@localhost:8080/orawsv/TEST/GET_DESCRIPTION?WSDL
