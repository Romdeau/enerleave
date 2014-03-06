json.array!(@toil_requests) do |toil_request|
  json.extract! toil_request, :id, :user_id, :initial_amount, :amount, :date_accrued, :approved
  json.url toil_request_url(toil_request, format: :json)
end
