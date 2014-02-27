json.array!(@leave_requests) do |leave_request|
  json.extract! leave_request, :id, :employee, :start_date, :end_date
  json.url leave_request_url(leave_request, format: :json)
end
