SELECT t.* FROM cdb_services t ORDER BY 1;

/*
BEGIN
  DBMS_SERVICE.create_service('my_cdb_service','my_cdb_service');
  DBMS_SERVICE.start_service('my_cdb_service');
END;
*/

/*
BEGIN
  DBMS_SERVICE.stop_service('my_cdb_service');
  DBMS_SERVICE.delete_service('my_cdb_service');
END;
*/
