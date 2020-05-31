ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER test CASCADE;
CREATE USER test IDENTIFIED BY test QUOTA UNLIMITED ON users;
GRANT CONNECT, CREATE TABLE, CREATE PROCEDURE TO test;

GRANT XDB_WEBSERVICES TO test;
GRANT XDB_WEBSERVICES_OVER_HTTP TO test;
-- GRANT XDB_WEBSERVICES_WITH_PUBLIC TO test;

CREATE TABLE test.test_tab (
  id          NUMBER,
  description VARCHAR2(50),
  CONSTRAINT test_tab_pk PRIMARY KEY (id)
);

INSERT INTO test.test_tab (id, description) VALUES (1, 'ONE');
INSERT INTO test.test_tab (id, description) VALUES (2, 'TWO');
INSERT INTO test.test_tab (id, description) VALUES (3, 'THREE');
COMMIT;

CREATE OR REPLACE FUNCTION test.get_test 
RETURN VARCHAR2 IS
BEGIN
  RETURN 'OK';
END;
/

CREATE OR REPLACE PROCEDURE test.get_description (
  p_id          IN  test_tab.id%TYPE,
  p_description OUT test_tab.description%TYPE) AS
BEGIN
  SELECT description
  INTO   p_description
  FROM   test.test_tab
  WHERE  id = p_id;
END;
/
