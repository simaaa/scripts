select t.* from dba_hist_sqlstat t where 1=1
--and t.sql_id = 'bdha7s5gbbdzj'
order by t.sql_id, t.loaded_versions desc
