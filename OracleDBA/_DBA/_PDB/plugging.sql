-- https://oracle-base.com/articles/12c/multitenant-create-and-configure-pluggable-database-12cr1

/*
ALTER PLUGGABLE DATABASE pdb2 CLOSE;
ALTER PLUGGABLE DATABASE pdb2 UNPLUG INTO '/u01/app/oracle/oradata/cdb1/pdb2/pdb2.xml';
DROP PLUGGABLE DATABASE pdb2 KEEP DATAFILES;
*/

/*
CREATE PLUGGABLE DATABASE pdb2 USING '/u01/app/oracle/oradata/cdb1/pdb2/pdb2.xml'
  NOCOPY
  TEMPFILE REUSE;
ALTER PLUGGABLE DATABASE pdb2 OPEN READ WRITE;
CREATE PLUGGABLE DATABASE pdb3 USING '/u01/app/oracle/oradata/cdb1/pdb2/pdb2.xml'
  FILE_NAME_CONVERT=('/u01/app/oracle/oradata/cdb1/pdb2/','/u01/app/oracle/oradata/cdb1/pdb3/');
*/

--SET SERVEROUTPUT ON
DECLARE
  l_result BOOLEAN;
BEGIN
  l_result := DBMS_PDB.check_plug_compatibility(
    pdb_descr_file => '/u01/app/oracle/oradata/cdb1/pdb2/pdb2.xml',
    pdb_name       => 'pdb2');
  IF l_result THEN
    DBMS_OUTPUT.PUT_LINE('compatible');
  ELSE
    DBMS_OUTPUT.PUT_LINE('incompatible');
  END IF;
END;
