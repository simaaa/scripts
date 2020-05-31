select --t.adr_home, t.filename, t.originating_timestamp,
  to_char(t.originating_timestamp,'YYYY.MM.DD HH24:MI:SS.FF3') as timestamp,
  t.component_id, t.message_text
  --,t.message_type, t.message_level, t.client_id, t.module_id, t.process_id, t.thread_id, t.user_id
  --,t.*
from sys.v_$diag_alert_ext t where 1=1
--and t.component_id = 'rdbms'
and t.originating_timestamp > systimestamp - interval '2' day
--and message_text like '%ora-%'
order by t.originating_timestamp desc;
