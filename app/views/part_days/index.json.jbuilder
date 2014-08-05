json.array!(@part_days) do |part_day|
  json.extract! part_day, :id, :leave_request_id, :leave_date, :time
  json.url part_day_url(part_day, format: :json)
end
