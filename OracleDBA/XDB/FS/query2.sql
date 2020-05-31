SELECT
  t.any_path, t.display_name, t.content_type, t.is_container, t.is_file_exist, t.file_length,
  CASE
    WHEN t.is_container = 0 AND t.is_file_exist = 1 AND t.file_length > 0 THEN DBMS_XSLPROCESSOR.read2clob(ADM_FS.get_dir_name, display_name)
  END AS file_content
  --,FILE_TYPE.get_file_name( FILE_TYPE(ExtractValue(t.res,'/Resource/DisplayName')) ) AS file_name
  --,NULL AS "    "
  --,FILE_TYPE(ExtractValue(t.res,'/Resource/DisplayName'))                           AS file_type
  --,FILE_TYPE.get_file( FILE_TYPE(ExtractValue(t.res,'/Resource/DisplayName')) )     AS get_file
  --,FILE_TYPE.get_content( FILE_TYPE(ExtractValue(t.res,'/Resource/DisplayName')) )  AS file_content
FROM (
  SELECT
    r.any_path                             AS any_path,
    r.res                                  AS res,
    r.display_name                         AS display_name,
    r.content_type                         AS content_type,
    DECODE(r.container,'true',1,0)         AS is_container,
    ADM_FS.is_file_exists(r.display_name)  AS is_file_exist,
    ADM_FS.get_file_length(r.display_name) AS file_length
  FROM (
    SELECT
      any_path,
      res,
      ExtractValue(res,'/Resource/DisplayName') AS display_name,
      ExtractValue(res,'/Resource/ContentType') AS content_type,
      ExtractValue(res,'/Resource/@Container')  AS container
    FROM resource_view
    WHERE under_path(res,'/public/ADMIN') = 1
    --AND equals_path(res,'/public/ADMIN/.env.sh') = 1
  ) r
) t
WHERE t.IS_CONTAINER = 0
ORDER BY t.any_path;
