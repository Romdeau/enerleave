class AddUserToLeaveRequest < ActiveRecord::Migration
  def change
    add_column :leave_requests, :approved, :string
  end
end
