json.array!(@flights) do |flight|
  json.extract! flight, :id, :preffered_flight, :preffered_time, :takeoff_location, :landing_location
  json.url flight_url(flight, format: :json)
end
