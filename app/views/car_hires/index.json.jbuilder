json.array!(@car_hires) do |car_hire|
  json.extract! car_hire, :id, :driver, :pickup_location, :pickup_date, :dropoff_date, :dropoff_location, :comment
  json.url car_hire_url(car_hire, format: :json)
end
