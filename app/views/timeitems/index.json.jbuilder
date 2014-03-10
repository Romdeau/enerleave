json.array!(@timeitems) do |timeitem|
  json.extract! timeitem, :id, :user_id, :timesheet_id, :start_time, :end_time, :description, :cost_center_id, :project_id
  json.url timeitem_url(timeitem, format: :json)
end
