json.array!(@travel_legs) do |travel_leg|
  json.extract! travel_leg, :id, :date_start, :date_end, :flight, :flight_comment, :car, :car_comment, :accommodation, :accommodation
  json.url travel_leg_url(travel_leg, format: :json)
end
