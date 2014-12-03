class AddManagerApprovedToToilRequests < ActiveRecord::Migration
  def change
    add_column :toil_requests, :manager_approved, :boolean, :default => false
    add_column :spend_toils, :manager_approved, :boolean, :default => false
  end
end
