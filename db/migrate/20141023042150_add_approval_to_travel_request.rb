class AddApprovalToTravelRequest < ActiveRecord::Migration
  def change
    add_column :travel_requests, :manager_approved, :boolean
  end
end
