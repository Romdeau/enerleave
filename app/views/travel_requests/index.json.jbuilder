json.array!(@travel_requests) do |travel_request|
  json.extract! travel_request, :id, :start_date, :end_date, :comment
  json.url travel_request_url(travel_request, format: :json)
end
