SELECT
  --t.*,
  t.any_path, t.display_name, t.content_type, t.is_file_exist, t.file_length, t.is_binary, t.is_text, t.is_xml, t.is_image, t.is_compressed, --t.content_clob as content_clob_orig,
  CASE
    WHEN t.is_binary = 0 AND t.is_text = 1 THEN t.content_clob
    WHEN t.is_binary = 0 AND t.is_xml = 1 THEN t.res.getClobVal()
    WHEN t.is_binary = 1 AND t.content_type = 'application/octet-stream' THEN ADM_FS.blob_to_clob(t.content_blob)
  END AS content_clob,
  t.content_blob,
  CASE
    WHEN t.is_file_exist = 1 AND t.file_length > 0 THEN DBMS_XSLPROCESSOR.read2clob(ADM_FS.get_dir_name, t.display_name)
  END AS file_content
  ,CASE WHEN t.display_name = '.env.sh' THEN DBMS_LOB.substr( ADM_FS.blob_to_clob(t.content_blob),4000,1) END AS comp_xdb
  ,CASE WHEN t.is_file_exist = 1 THEN DBMS_LOB.substr( DBMS_XSLPROCESSOR.read2clob(ADM_FS.get_dir_name, t.display_name),4000,1) END AS comp_file
FROM (
  SELECT
    rv.any_path                                           AS any_path,
    rv.res                                                AS res,
    rv.display_name                                       AS display_name,
    rv.content_type                                       AS content_type,
    ADM_FS.is_file_exists(rv.display_name)                AS is_file_exist,
    ADM_FS.get_file_length(rv.display_name)               AS file_length,
    rv.is_binary                                          AS is_binary,
    DECODE(INSTR(LOWER(content_type),'text/plain'),0,0,1) AS is_text,
    DECODE(INSTR(LOWER(content_type),'xml'),0,0,1)        AS is_xml,
    DECODE(INSTR(LOWER(content_type),'image'),0,0,1)      AS is_image,
    DECODE(INSTR(LOWER(content_type),'compressed'),0,0,1) AS is_compressed,
    CASE WHEN rv.is_binary = 0 THEN rv.content_clob END                      AS content_clob,
    CASE WHEN rv.is_binary = 1 THEN ADM_FS.clob_to_blob(rv.content_clob) END AS content_blob
  FROM (
    SELECT
      any_path,
      res,
      ExtractValue(res,'/Resource/DisplayName')   AS display_name,
      ExtractValue(res,'/Resource/ContentType')   AS content_type,
      ExistsNode(res,'/Resource/Contents/binary') AS is_binary,
      content_clob
    FROM resource_view, XmlTable('/' passing extract(res, '/Resource/Contents') columns content_clob clob path '/*')
  ) rv
) t
WHERE under_path(t.res, '/public/ADMIN/') = 1
--WHERE under_path(t.res, '/') = 1
--WHERE under_path(t.res, gc_SCRIPTS_XDB_PATH) = 1
--AND equals_path(t.res, '/public/ADMIN/.env.sh') = 1
--AND t.any_path LIKE '/public/ADMIN/m%'
AND t.is_file_exist = 1
ORDER BY t.any_path;
