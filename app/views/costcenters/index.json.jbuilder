json.array!(@costcenters) do |costcenter|
  json.extract! costcenter, :id, :cost_code, :description
  json.url costcenter_url(costcenter, format: :json)
end
