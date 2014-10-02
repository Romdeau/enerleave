json.array!(@accommodations) do |accommodation|
  json.extract! accommodation, :id, :preffered_location, :check_in, :check_out, :comment
  json.url accommodation_url(accommodation, format: :json)
end
