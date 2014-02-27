class CreateLeaveRequests < ActiveRecord::Migration
  def change
    create_table :leave_requests do |t|
      t.string :employee
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
