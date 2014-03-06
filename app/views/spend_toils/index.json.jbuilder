json.array!(@spend_toils) do |spend_toil|
  json.extract! spend_toil, :id
  json.url spend_toil_url(spend_toil, format: :json)
end
