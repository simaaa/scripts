select m.* from apex_040000.wwv_flow_collection_members$ m;
select c.* from apex_040000.wwv_flow_collections$ c where 1=1
--and user_id = 'LORINCZZ'
order by user_id, collection_name;
