declare
  v_ws_id number;
  v_app_id number := 230;
  v_session_id number := 375057327237377;
begin
  begin
    select workspace_id into v_ws_id from apex_workspaces;
  exception
    when no_data_found then
      dbms_output.put_line(sqlerrm);
  end;
  wwv_flow_api.set_security_group_id(v_ws_id);
  wwv_flow.g_flow_id := v_app_id;
  wwv_flow.g_instance := v_session_id;
end;
/
