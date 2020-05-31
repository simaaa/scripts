SELECT
  --tt.*
  tt.any_path, tt.res, tt.display_name, tt.content_type
  ,DECODE(DBMS_LOB.compare(tt.content_clob_all, tt.file_content),0,1,0) as compare
  ,DBMS_LOB.substr(tt.content_clob_all,2000,1) as comp_xdb
  ,DBMS_LOB.substr(tt.file_content,2000,1) as comp_xdb
FROM (
  SELECT
    --t.*,
    t.any_path, t.res, t.display_name, t.content_type, t.is_file_exist, t.file_length, t.is_binary, t.is_text, t.is_xml, t.is_image, t.is_compressed, --t.content_clob as content_clob_orig,
    CASE
      WHEN t.is_binary = 0 AND t.is_text = 1 THEN t.content_clob
      WHEN t.is_binary = 0 AND t.is_xml = 1 THEN t.res.getClobVal()
      WHEN t.is_binary = 1 AND t.content_type = 'application/octet-stream' THEN ADM_FS.blob_to_clob(t.content_blob)
    END AS content_clob_all,
    t.content_blob,
    CASE
      WHEN t.is_file_exist = 1 AND t.file_length > 0 THEN DBMS_XSLPROCESSOR.read2clob(ADM_FS.get_dir_name, t.display_name)
    END AS file_content
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
) tt
WHERE under_path(tt.res, '/public/ADMIN/') = 1
--AND equals_path(tt.res, '/public/ADMIN/.env.sh') = 1
AND ( tt.display_name LIKE '%.sh' OR tt.display_name LIKE '%.txt' )
--AND tt.is_file_exist = 1
