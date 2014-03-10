class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.references :user, index: true
      t.references :timeweek, index: true
      t.date :timesheet_date, index: true

      t.timestamps
    end
  end
end
