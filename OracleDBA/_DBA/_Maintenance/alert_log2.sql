select t.originating_timestamp, t.client_id, t.module_id, t.process_id, t.thread_id, t.message_text
from sys.v_$diag_alert_ext t
-- 9/7/2018 2:42:25
where t.originating_timestamp between timestamp'2018-09-07 02:40:00' and timestamp'2018-09-07 03:00:00'
--where t.originating_timestamp >= timestamp'2018-09-07 02:42:00'
order by indx;
