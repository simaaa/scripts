SELECT
  rv.any_path                                                                        AS any_path,
  ExtractValue(rv.res,'/Resource/DisplayName')                                       AS display_name,
  ExtractValue(rv.res,'/Resource/ContentType')                                       AS content_type,
  DECODE(ExtractValue(rv.res,'/Resource/@Container'),'true',1,0)                     AS is_container,
  FILE_TYPE.get_file_name( FILE_TYPE(ExtractValue(rv.res,'/Resource/DisplayName')) ) AS file_name,
  NULL AS "    "
  ,FILE_TYPE(ExtractValue(rv.res,'/Resource/DisplayName'))                           AS file_type
  --,FILE_TYPE.get_file( FILE_TYPE(ExtractValue(rv.res,'/Resource/DisplayName')) )     AS get_file
  --,FILE_TYPE.get_content( FILE_TYPE(ExtractValue(rv.res,'/Resource/DisplayName')) )  AS file_content
FROM resource_view rv
WHERE under_path(rv.res,'/public/ADMIN') = 1
--AND equals_path(rv.res,'/public/ADMIN/.env.sh') = 1
ORDER BY rv.any_path;
