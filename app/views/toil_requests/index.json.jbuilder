json.array!(@toil_requests) do |toil_request|
  json.extract! toil_request, :id, :user_id, :claim_date, :claim_hours, :approver_id
  json.url toil_request_url(toil_request, format: :json)
end
