class AddLeaveTypeToLeaveRequest < ActiveRecord::Migration
  def change
  	add_column :leave_requests, :leave_type, :string
  	add_column :leave_requests, :comment, :string
  end
end
