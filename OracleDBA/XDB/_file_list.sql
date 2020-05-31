SELECT
  rv.any_path                                                    AS any_path,
  ExtractValue(rv.res,'/Resource/DisplayName')                   AS display_name,
  ExtractValue(rv.res,'/Resource/ContentType')                   AS content_type,
  DECODE(ExtractValue(rv.res,'/Resource/@Container'),'true',1,0) AS is_container,
  ExistsNode(rv.res,'/Resource/Contents')                        AS is_content,
  ExistsNode(rv.res,'/Resource/Contents/binary')                 AS is_binary,
  rv.res,
  rv.res.getClobVal()
FROM resource_view rv
--WHERE under_path(rv.res,'/public') = 1
ORDER BY rv.any_path;
