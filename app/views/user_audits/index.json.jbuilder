json.array!(@user_audits) do |user_audit|
  json.extract! user_audit, :id, :user_id, :action, :description, :end_user
  json.url user_audit_url(user_audit, format: :json)
end
