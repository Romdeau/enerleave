json.array!(@timeweeks) do |timeweek|
  json.extract! timeweek, :id, :user_id, :start_date
  json.url timeweek_url(timeweek, format: :json)
end
